/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol Closable: Sendable {

    var isClosed: Bool { get }

    func close() async throws
}
