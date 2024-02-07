/*
 See LICENSE for this package's licensing information.
*/

import Foundation

struct Lock: Sendable {

    // MARK: - Private properties

    private let _lock = NSLock()

    // MARK: - Inits

    init() {}

    // MARK: - Internal methods

    func lock() {
        _lock.lock()
    }

    func unlock() {
        _lock.unlock()
    }

    func withLock<T>(_ block: () throws -> T) rethrows -> T {
        defer { unlock() }
        lock()
        return try block()
    }

    func withLockVoid(_ block: () throws -> Void) rethrows {
        defer { unlock() }
        lock()
        try block()
    }
}
