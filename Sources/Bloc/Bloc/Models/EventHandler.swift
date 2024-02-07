/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public typealias EventHandler<Event: Sendable, State: Sendable> = (Event, State) async throws -> Void
