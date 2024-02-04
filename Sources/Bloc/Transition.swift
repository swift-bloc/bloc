import Foundation

public struct Transition<Event, State> {

    public let currentState: State
    public let event: Event
    public let nextState: State

    public init(
        currentState: State,
        event: Event,
        nextState: State
    ) {
        self.currentState = currentState
        self.event = event
        self.nextState = nextState
    }
}

extension Transition: Equatable where Event: Equatable, State: Equatable {}

extension Transition: Hashable where Event: Hashable, State: Hashable {}
