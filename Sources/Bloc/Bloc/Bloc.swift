/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public class Bloc<Event, State>: BlocBase<State>, BlocEventSink {

    // MARK: - Public properties

    open var transformer: EventTransformer<Event> {
        fatalError("getter:transformer has not been implemented")
    }

    // MARK: - Private properties

    private let lock = Lock()
    private let eventController = StreamController<Event>()

    // MARK: - Unsafe properties

    private var _handlers = [BlocHandler]()
    private var _emitters = [BlocEmitter<State>]()

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
