/*
 See LICENSE for this package's licensing information.
*/

import Foundation

class StreamNode<Element: Sendable>: @unchecked Sendable {

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
