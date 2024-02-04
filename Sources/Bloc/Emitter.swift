import Foundation

public protocol Emitter<State> {

    associatedtype State

    var isDone: Bool { get }

    func onEach<T>(
        _ stream: Stream<T>,
        onData: @escaping (T) -> Void,
        onError: ((Error) -> Void)?
    ) async throws

    func forEach<T>(
        _ stream: Stream<T>,
        onData: @escaping (T) -> State,
        onError: ((Error) -> Void)?
    ) async throws

    func callAsFunction(_ state: State)
}

extension Emitter {

    public func forEach<T>(
        _ stream: Stream<T>,
        onData: @escaping (T) -> Void
    ) async throws {
        try await onEach(stream, onData: onData, onError: nil)
    }

    public func onEach<T>(
        _ stream: Stream<T>,
        onData: @escaping (T) -> State
    ) async throws {
        try await forEach(stream, onData: onData, onError: nil)
    }
}

class _Emitter<State>: Emitter {

    private let emit: (State) -> Void
    private let isCanceled = false
    private let isCompleted = false

    // _completer should be a semaphore

    var isDone: Bool {
        fatalError("getter:isDone has not been implemented")
    }

    init(_ emit: @escaping (State) -> Void) {
        fatalError("init(_:) has not been implemented")
    }

    func onEach<T>(
        _ stream: Stream<T>,
        onData: @escaping (T) -> Void,
        onError: ((Error) -> Void)?
    ) async throws {
        fatalError("onEach(_:onData:onError:) has not been implemented")
    }

    func forEach<T>(
        _ stream: Stream<T>,
        onData: @escaping (T) -> State,
        onError: ((Error) -> Void)?
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

    private func close() {
        fatalError("close() has not been implemented")
    }

    // Renamed from future
    public var result: Void {
        get async throws {
            fatalError("getter:result has not been implemented")
        }
    }
}
