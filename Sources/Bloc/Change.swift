/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public struct Change<State: Sendable>: Sendable {

    // MARK: - Public properties

    public let currentState: State
    public let nextState: State

    // MARK: - Inits

    public init(currentState: State, nextState: State) {
        self.currentState = currentState
        self.nextState = nextState
    }
}

extension Change: Equatable where State: Equatable {}

extension Change: Hashable where State: Hashable {}
