/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol StateStreamable<State>: Streamable {

    var state: State { get }
}
