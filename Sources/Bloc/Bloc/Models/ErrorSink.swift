/*
 See LICENSE for this package's licensing information.
*/

import Foundation

public protocol ErrorSink: Closable {

    func addError(_ error: Error)
}
