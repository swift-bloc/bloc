/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol Streamable<State>: Sendable {

    associatedtype State: Sendable

    var stream: Stream<State> { get }
}

public protocol StateStreamable<State>: Streamable {

    var state: State { get }
}

public protocol StateStreamableSource<State>: StateStreamable, Closable {}

public protocol Closable: Sendable {

    var isClosed: Bool { get }

    func close() async throws
}

protocol Emittable<_State>: Sendable {

    associatedtype _State: Sendable

    func emit(_ state: _State) throws
}

public protocol ErrorSink: Closable {

    func addError(_ error: Error)
}

open class BlocBase<State>: StateStreamableSource, Emittable, ErrorSink, @unchecked Sendable {

    // MARK: - Open properties

    open var observer: BlocObserver {
        fatalError("getter:observer has not been implemented")
    }

    // MARK: - Public properties

    public var stream: Stream<State> {
        fatalError("getter:stream has not been implemented")
    }

    public var isClosed: Bool {
        fatalError("getter:isClosed has not been implemented")
    }

    public var state: State {
        lock.withLock { _state }
    }

    // MARK: - Private properties

    private let lock = Lock()
    private let streamController = StreamController<State>()

    // MARK: - Unsafe properties

    private var _emitted = false
    private var _state: State

    // MARK: - Inits

    public init(_ state: State) {
        defer { observer.onCreate(self) }
        self._state = state
    }

    // MARK: - Open methods

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

    // MARK: - Internal methods

    func emit(_ state: State) throws {
        fatalError("emit(_:) has not been implemented")
    }
}
