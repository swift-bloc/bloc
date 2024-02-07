/*
 See LICENSE for this package's licensing information.
*/

import Foundation

class StreamController<Element: Sendable>: @unchecked Sendable {

    // MARK: - Internal properties

    var stream: Stream<Element> {
        .init { [weak self] in
            guard let self else {
                return nil
            }

            return self.lock.withLock {
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
