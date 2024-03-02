/*
 See LICENSE for this package's licensing information.
*/

import Foundation

open class BlocBase<State: Equatable>: StateStreamableSource, Emittable, ErrorSink, @unchecked Sendable {

    // MARK: - Open properties

    open var observer: BlocObserver

    // MARK: - Public properties

    public var stream: Stream<State> {
        return streamController.stream
    }

    public var isClosed: Bool {
        return streamController.isClosed
    }

    public var state: State {
        lock.withLock { _state }
    }

    // MARK: - Private properties

    private let lock = Lock()
    private let streamController = StreamController<State>()

    // MARK: - Unsafe properties

    private var _emitted = false
    private var _state: State

    // MARK: - Inits

    public init(_ state: State, observer: BlocObserver) {
        self._state = state
        self.observer = observer
        observer.onCreate(self)
    }

    // MARK: - Open methods

    open func onChange(_ change: Change<State>) {
        observer.onChange(self, change)
    }

    open func addError(_ error: Error) {
        onError(error)
    }

    open func onError(_ error: Error) {
        observer.onError(self, error)
        }

    open func close() async {
        observer.onClose(self)
            await streamController.close()
        }

    public func emit(_ state: State) {
            guard !isClosed else {
                fatalError("Cannot emit new states after calling close")
            }
            guard state != _state || !_emitted else { return }
            
            onChange(Change(currentState: _state, nextState: state))
            self._state = state
            streamController.add(state)
            _emitted = true
        }
}
