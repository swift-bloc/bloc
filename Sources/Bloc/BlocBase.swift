import Foundation

public protocol Streamable<State> {

    associatedtype State

    var stream: Stream<State> { get }
}

public protocol StateStreamable<State>: Streamable {

    var state: State { get }
}

public protocol StateStreamableSource<State>: StateStreamable, Closable {}

public protocol Closable {

    var isClosed: Bool { get }

    func close() async throws
}

protocol Emittable<_State> {

    associatedtype _State

    func emit(_ state: _State) throws
}

public protocol ErrorSink: Closable {

    func addError(_ error: Error)
}

public struct Stream<Element>: AsyncSequence {

    public struct AsyncIterator: AsyncIteratorProtocol {

        public mutating func next() async throws -> Element? {
            fatalError("next() has not been implemented")
        }
    }

    public func makeAsyncIterator() -> AsyncIterator {
        fatalError("makeAsyncIterator() has not been implemented")
    }
}

open class BlocBase<State>: StateStreamableSource, Emittable, ErrorSink {

    public var stream: Stream<State> {
        fatalError("getter:stream has not been implemented")
    }

    public var isClosed: Bool {
        fatalError("getter:isClosed has not been implemented")
    }

    private(set) public var state: State

    private var _emitted = false

    open var observer: BlocObserver { 
        fatalError("getter:observer has not been implemented")
    }

    public init(_ state: State) {
        fatalError("init(_:) has not been implemented")
    }

    func emit(_ state: State) throws {
        fatalError("emit(_:) has not been implemented")
    }

    open func onChange(_ change: Change<State>) {
        fatalError("onChange(_:) has not been implemented")
    }

    open func addError(_ error: Error) {
        fatalError("addError(_:) has not been implemented")
    }

    open func onError(_ error: Error) {
        fatalError("onError(_:) has not been implemented")
    }

    open func close() async throws {
        fatalError("close() has not been implemented")
    }
}
