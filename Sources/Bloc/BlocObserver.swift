import Foundation

open class BlocObserver {

    public init() {}

    open func onCreate(_ bloc: Any) {}

    open func onEvent(
        _ bloc: Any,
        _ event: Any?
    ) {}

    open func onChange(
        _ bloc: Any,
        _ change: Change<Any>
    ) {}

    open func onTransition(
        _ bloc: Any,
        _ transition: Transition<Any, Any>
    ) {}

    open func onError(
        _ bloc: Any,
        _ error: Error
    ) {}

    open func onClose(_ bloc: Any) {}
}
