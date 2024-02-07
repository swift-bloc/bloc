import XCTest
@testable import Bloc

final class BlocTests: XCTestCase {

    func testStream() async throws {
        let streamController = StreamController<Int>()

        streamController.stream.listen {
            print("[Data 1]", $0)
        } onDone: {
            print("[Done 1]")
        } onError: {
            print("[Error 1]", $0)
        }

        try await Task.sleep(nanoseconds: 1_000_000_000)
        streamController.add(1)

        streamController.stream.listen {
            print("[Data 2]", $0)
        } onDone: {
            print("[Done 2]")
        } onError: {
            print("[Error 2]", $0)
        }

        try await Task.sleep(nanoseconds: 1_000_000_000)
        streamController.add(2)
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        streamController.add(failure: NSError(domain: "Teste", code: 100))
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        streamController.add(3)
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        streamController.close()
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }

    func testExample() throws {
        XCTFail("Tests not implemented yet")
    }
}
