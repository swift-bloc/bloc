/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public typealias EventMapper<Event: Sendable> = (Event) throws -> Stream<Event>
