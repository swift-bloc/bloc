import Foundation

public protocol BlocEventSink<Event>: ErrorSink {

    associatedtype Event

    func add(_ event: Event)
}

public typealias EventHandler<Event, State> = (Event, State) async throws -> Void

public typealias EventMapper<Event> = (Event) throws -> Stream<Event>

public typealias EventTransformer<Event> = (
  Stream<Event>,
  EventMapper<Event>
) throws -> Stream<Event>

public class Bloc<Event, State>: BlocBase<State>, BlocEventSink {

    public override init(_ state: State) {
        fatalError("init(_:) has not been implemented")
    }

    public func add(_ event: Event) {
        fatalError("add(_:) has not been implemented")
    }

    open func onEvent(_ event: Event) {
        fatalError("onEvent(_:) has not been implemented")
    }

    public func on<E>(
        _ eventType: E.Type,
        _ handler: EventHandler<E, State>,
        transformer: EventTransformer<E>? = nil
    ) {
        fatalError("on(_:) has not been implemented")
    }

    open func onTransition(_ transition: Transition<Event, State>) {
        fatalError("onTransition(_:) has not been implemented")
    }

    open override func close() async throws {
        fatalError("close(_:) has not been implemented")
    }
}
