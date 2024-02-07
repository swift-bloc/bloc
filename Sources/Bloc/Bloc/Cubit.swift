/*
 See LICENSE for this package's licensing information.
*/

import Foundation

open class Cubit<State>: BlocBase<State> {

    // MARK: - Inits

    public override init(_ state: State) {
        super.init(state)
    }
}
