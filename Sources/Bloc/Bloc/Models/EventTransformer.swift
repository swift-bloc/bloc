/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public typealias EventTransformer<Event: Sendable> = (
  Stream<Event>,
  EventMapper<Event>
) throws -> Stream<Event>
