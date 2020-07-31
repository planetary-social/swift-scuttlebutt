import XCTest

@testable import Scuttlebutt

final class BotIntegrationTests: XCTestCase {

    func testSetup() {
        _ = ScuttleBot()
        XCTFail("TODO: Write tests!")
    }

    static var allTests = [
        ("test settng up a bot", testSetup),
    ]

}
