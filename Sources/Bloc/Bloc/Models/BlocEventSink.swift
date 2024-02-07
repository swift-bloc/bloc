/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol BlocEventSink<Event>: ErrorSink {

    associatedtype Event: Sendable

    func add<E>(_ event: E)
}
