/*
 See LICENSE for this package's licensing information.
*/

import Foundation

private class StreamNode<Element: Sendable>: @unchecked Sendable {

    // MARK: - Internal properties

    var next: (Element, StreamNode<Element>)? {
        get async {
            lock.lock()

            if _isClosed || _next != nil {
                defer { lock.unlock() }
                return _next
            }

            lock.unlock()
            await semaphore.wait()

            defer { lock.unlock() }
            lock.lock()
            return _next
        }
    }

    // MARK: - Private properties

    private let semaphore = AsyncSemaphore()
    private let lock = Lock()

    private var _isClosed: Bool = false
    private var _next: (Element, StreamNode<Element>)?

    // MARK: - Inits

    init() {}

    // MARK: - Internal methods

    func produce(_ element: Element) -> StreamNode<Element> {
        lock.withLock {
            if let (_, _next) = _next {
                return _next.produce(element)
            }

            let next = StreamNode<Element>()
            _next = (element, next)
            semaphore.perform()
            return next
        }
    }

    func close() {
        lock.withLockVoid {
            _isClosed = true
            _next = nil
            semaphore.perform()
        }
    }
}

public struct Stream<Element: Sendable>: AsyncSequence, Sendable {

    fileprivate typealias Node = StreamNode<Result<Element, Error>>

    public struct AsyncIterator: AsyncIteratorProtocol, Sendable {

        // MARK: - Private properties

        fileprivate var node: Node?

        // MARK: - Public methods

        public mutating func next() async throws -> Element? {
            guard let node, let (element, node) = await node.next else {
                return nil
            }

            defer { self.node = node }

            switch element {
            case .success(let success):
                return success
            case .failure(let failure):
                throw failure
            }
        }
    }

    // MARK: - Private properties

    private let node: @Sendable () -> Node?

    // MARK: - Inits

    fileprivate init(_ node: @escaping @Sendable () -> Node?) {
        self.node = node
    }

    // MARK: - Public methods

    public func makeAsyncIterator() -> AsyncIterator {
        .init(node: node())
    }

    @discardableResult
    public func listen(
        priority: TaskPriority? = nil,
        onData: @escaping @Sendable (Element) -> Void,
        onDone: (@Sendable () -> Void)? = nil
    ) -> Task<Void, Error> {
        Task(priority: priority) {
            for try await element in self {
                onData(element)
            }

            onDone?()
        }
    }

    @discardableResult
    public func listen(
        priority: TaskPriority? = nil,
        onData: @escaping @Sendable (Element) -> Void,
        onDone: (@Sendable () -> Void)? = nil,
        onError: @escaping @Sendable (Error) -> Void
    ) -> Task<Void, Never> {
        Task(priority: priority) {
            while true {
                do {
                    for try await element in self {
                        onData(element)
                    }

                    onDone?()
                    return
                } catch {
                    onError(error)
                }
            }
        }
    }
}

class StreamController<Element: Sendable>: @unchecked Sendable {

    // MARK: - Internal properties

    var stream: Stream<Element> {
        .init { [weak self] in
            guard let self else {
                return nil
            }

            return lock.withLock {
                self._node
            }
        }
    }

    var isClosed: Bool {
        lock.withLock { _isClosed }
    }

    // MARK: - Private properties

    private let lock = Lock()

    // MARK: - Unsafe properties

    private var _node = StreamNode<Result<Element, Error>>()
    private var _isClosed = false

    // MARK: - Inits

    init() {}

    // MARK: - Internal methods

    func add(_ element: Element) {
        lock.withLockVoid {
            guard !_isClosed else {
                return
            }

            _node = _node.produce(.success(element))
        }
    }

    func add(failure error: Error) {
        lock.withLockVoid {
            guard !_isClosed else {
                return
            }

            _node = _node.produce(.failure(error))
        }
    }

    func close() {
        lock.withLockVoid {
            guard !_isClosed else {
                return
            }

            _isClosed = true
            _node.close()
            _node = .init()
            _node.close()
        }
    }
}
