/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol BlocObserver: Sendable {

    func onCreate<State>(_ bloc: BlocBase<State>)

    func onEvent<Event, State>(
        _ bloc: Bloc<Event, State>,
        _ event: Event
    )

    func onChange<State>(
        _ bloc: BlocBase<State>,
        _ change: Change<State>
    )

    func onTransition<Event, State>(
        _ bloc: Bloc<Event, State>,
        _ transition: Transition<Event, State>
    )

    func onError<State>(
        _ bloc: BlocBase<State>,
        _ error: Error
    )

    func onClose<State>(_ bloc: BlocBase<State>)
}

extension BlocObserver {

    public func onCreate<State>(_ bloc: BlocBase<State>) {}

    public func onEvent<Event, State>(
        _ bloc: Bloc<Event, State>,
        _ event: Event
    ) {}

    public func onChange<State>(
        _ bloc: BlocBase<State>,
        _ change: Change<State>
    ) {}

    public func onTransition<Event, State>(
        _ bloc: Bloc<Event, State>,
        _ transition: Transition<Event, State>
    ) {}

    public func onError<State>(
        _ bloc: BlocBase<State>,
        _ error: Error
    ) {}

    public func onClose<State>(_ bloc: BlocBase<State>) {}
}
