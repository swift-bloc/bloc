import Foundation

public struct Change<State> {

    public let currentState: State
    public let nextState: State

    public init(currentState: State, nextState: State) {
        self.currentState = currentState
        self.nextState = nextState
    }
}

extension Change: Equatable where State: Equatable {}

extension Change: Hashable where State: Hashable {}
