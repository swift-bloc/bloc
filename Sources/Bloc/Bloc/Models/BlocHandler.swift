/*
 See LICENSE for this package's licensing information.
*/

import Foundation

struct BlocHandler: Sendable {

    let isType: @Sendable (Sendable) -> Bool
    let type: Sendable.Type

    init(
        isType: @escaping @Sendable (Sendable) -> Bool,
        type: Sendable.Type
    ) {
        self.isType = isType
        self.type = type
    }
}
