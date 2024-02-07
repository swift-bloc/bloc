/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol Emitter<State>: Sendable {

    associatedtype State: Sendable

    var isDone: Bool { get }

    func onEach<T>(
        _ stream: Stream<T>,
        onData: @escaping @Sendable (T) -> Void,
        onError: (@Sendable (Error) -> Void)?
    ) async throws

    func forEach<T>(
        _ stream: Stream<T>,
        onData: @escaping @Sendable (T) -> State,
        onError: (@Sendable (Error) -> Void)?
    ) async throws

    func callAsFunction(_ state: State)
}

extension Emitter {

    public func forEach<T>(
        _ stream: Stream<T>,
        onData: @escaping @Sendable (T) -> Void
    ) async throws {
        try await onEach(stream, onData: onData, onError: nil)
    }

    public func onEach<T>(
        _ stream: Stream<T>,
        onData: @escaping @Sendable (T) -> State
    ) async throws {
        try await forEach(stream, onData: onData, onError: nil)
    }
}

class _Emitter<State>: Emitter, @unchecked Sendable {

    // MARK: - Internal properties
    
    var result: Void {
        get async throws {
            fatalError("getter:result has not been implemented")
        }
    }

    var isDone: Bool {
        fatalError("getter:isDone has not been implemented")
    }

    // MARK: - Private properties

    private let lock = Lock()
    private let completer = AsyncSemaphore()

    private let emit: @Sendable (State) -> Void

    // MARK: - Unsafe properties

    private var _activeTasks = [Task<Void, Error>]()

    private var _isCanceled = false
    private var _isCompleted = false

    // MARK: - Inits

    init(_ emit: @escaping @Sendable (State) -> Void) {
        self.emit = emit
    }

    // MARK: - Internal methods

    func onEach<T>(
        _ stream: Stream<T>,
        onData: @escaping @Sendable (T) -> Void,
        onError: (@Sendable (Error) -> Void)?
    ) async throws {
        fatalError("onEach(_:onData:onError:) has not been implemented")
    }

    func forEach<T>(
        _ stream: Stream<T>,
        onData: @escaping (T) -> State,
        onError: (@Sendable (Error) -> Void)?
    ) async throws {
        fatalError("forEach(_:onData:onError:) has not been implemented")
    }

    func callAsFunction(_ state: State) {
        fatalError("callAsFunction(_:) has not been implemented")
    }

    func cancel() {
        fatalError("cancel() has not been implemented")
    }

    func complete() {
        fatalError("complete() has not been implemented")
    }

    // MARK: - Private methods

    private func close() {
        fatalError("close() has not been implemented")
    }
}
