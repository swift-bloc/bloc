/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol Streamable<State>: Sendable {

    associatedtype State: Sendable

    var stream: Stream<State> { get }
}
