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
