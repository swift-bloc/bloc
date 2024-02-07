/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol BlocEventSink<Event>: ErrorSink {

    associatedtype Event: Sendable

    func add<E>(_ event: E)
}

public typealias EventHandler<Event: Sendable, State: Sendable> = (Event, State) async throws -> Void

public typealias EventMapper<Event: Sendable> = (Event) throws -> Stream<Event>

public typealias EventTransformer<Event: Sendable> = (
  Stream<Event>,
  EventMapper<Event>
) throws -> Stream<Event>

public class Bloc<Event, State>: BlocBase<State>, BlocEventSink {

    // MARK: - Public properties

    open var transformer: EventTransformer<Any> {
        fatalError("getter:transformer has not been implemented")
    }

    // MARK: - Private properties

    private let lock = Lock()
    private let eventController = StreamController<Event>()

    // MARK: - Unsafe properties

    private var _handlers = [_Handler]()
    private var _emitters = [_Emitter<Any>]()

    // MARK: - Inits

    public override init(_ state: State) {
        super.init(state)
    }

    // MARK: - Open methods

    open func onEvent(_ event: Event) {
        fatalError("onEvent(_:) has not been implemented")
    }

    open func onTransition(_ transition: Transition<Event, State>) {
        fatalError("onTransition(_:) has not been implemented")
    }

    open override func close() async throws {
        fatalError("close(_:) has not been implemented")
    }

    // MARK: - Public methods

    public func add<E>(_ event: E) {
        assert(event is Event, {
            """
            \(event) of type \(E.self) is not a value of type \(Event.self)
            """
        }())

        fatalError("add(_:) has not been implemented")
    }

    public func on<E>(
        _ eventType: E.Type,
        _ handler: EventHandler<E, State>,
        transformer: EventTransformer<E>? = nil
    ) {
        fatalError("on(_:) has not been implemented")
    }
}

struct _Handler {
    let isType: (Sendable) -> Bool
    let type: Sendable.Type

    init(
        isType: @escaping (Sendable) -> Bool,
        type: Sendable.Type
    ) {
        self.isType = isType
        self.type = type
    }
}

struct _DefaultBlocObserver: BlocObserver {}
