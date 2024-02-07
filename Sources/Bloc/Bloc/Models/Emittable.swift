/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol Emittable<State>: Sendable {

    associatedtype State: Sendable

    func emit(_ state: State) throws
}
