/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public struct Stream<Element: Sendable>: AsyncSequence, Sendable {

    typealias Node = StreamNode<Result<Element, Error>>

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

    init(_ node: @escaping @Sendable () -> Node?) {
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
