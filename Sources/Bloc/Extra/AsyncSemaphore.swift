/*
 See LICENSE for this package's licensing information.
*/

import Foundation

struct AsyncSemaphore: Sendable {

    private final class Node: @unchecked Sendable {

        // MARK: - Internal properties

        let task: Task

        var next: Node?
        weak var previous: Node?

        // MARK: - Inits

        init(_ task: Task) {
            self.task = task
            task.node = self
        }
    }

    private final class Storage: @unchecked Sendable {

        // MARK: - Internal properties

        var first: Task? {
            _first?.task
        }

        var last: Task? {
            _last?.task
        }

        var seed = UUID()

        // MARK: - Private properties

        private var _first: Node?
        private weak var _last: Node?

        // MARK: - Internal methods

        func append(_ task: Task) {
            assert(task.node == nil && task.seed == seed)

            let node = Node(task)
            let previous = _last ?? _first

            node.previous = previous
            previous?.next = node

            _last = node
            _first = _first ?? node
        }

        func remove(_ task: Task) {
            defer { task.node = nil }

            let node = task.node.unsafelyUnwrapped

            if node === _first {
                _first = node.next
                _first?.previous = nil
                return
            }

            let previous = node.previous

            if node === last {
                _last = previous
                previous?.next = nil
                return
            }

            let next = node.next

            previous?.next = next
            next?.previous = previous
        }

        deinit {
            let isEmpty = _first == nil && _last == nil
            precondition(isEmpty, "The AsyncLock is being deallocated with pending tasks. This is not safe.")
        }
    }

    private class Task: @unchecked Sendable {

        enum State {
            case pending
            case waiting(UnsafeContinuation<Void, Never>)
            case running
            case cancelled
        }

        // MARK: - Internal properties

        let seed: UUID
        var state: State
        weak var node: Node?

        // MARK: - Inits

        init(_ state: State, seed: UUID) {
            self.state = state
            self.seed = seed
        }
    }

    // MARK: - Private properties

    private let lock = Lock()

    // MARK: - Unsafe properties

    private let _storage: Storage

    // MARK: - inits

    init() {
        _storage = .init()
    }

    func wait() async {
        let task = startTask()

        await withTaskCancellationHandler {
            await withUnsafeContinuation { continuation in
                lock.withLock {
                    if case .cancelled = task.state {
                        _storage.remove(task)
                        return
                    }

                    if task.seed != _storage.seed {
                        task.state = .running
                        continuation.resume()
                        return
                    }

                    task.state = .waiting(continuation)
                }
            }
        } onCancel: {
            lock.withLock {
                if case .running = task.state {
                    return
                }

                task.state = .cancelled
                _storage.remove(task)
            }
        }
    }

    func perform() {
        lock.withLock {
            _resumeNextPendingTask()
        }
    }

    // MARK: - Private methods

    private func startTask() -> Task {
        lock.withLock {
            let task = Task(.pending, seed: _storage.seed)
            _storage.append(task)
            return task
        }
    }

    // MARK: - Unsafe methods

    private func _resumeNextPendingTask() {
        defer { _storage.seed = UUID() }

        guard let last = _storage.last else {
            return
        }

        var current = _storage.first
        let seed = _storage.seed

        while let task = current, task.seed == seed {
            current = task.node?.next?.task

            switch task.state {
            case .pending, .running, .cancelled:
                break
            case .waiting(let continuation):
                task.state = .running
                continuation.resume()
            }

            _storage.remove(task)

            if task === last {
                return
            }
        }
    }
}
