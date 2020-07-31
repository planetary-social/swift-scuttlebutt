import XCTest

@testable import Scuttlebutt

final class BotIntegrationTests: XCTestCase {

    private func inverted(_ e: XCTestExpectation) -> XCTestExpectation {
        e.isInverted = true
        return e
    }

    private func redundant(_ e: XCTestExpectation) -> XCTestExpectation {
        e.assertForOverFulfill = false
        return e
    }
        
    func testCompleteSetup() {
        let refreshRepeatCount = Int.random(in: 5...10)
        let testDeadline: TimeInterval = 5
        let cancelTime: DispatchTime = .now() + 4

        let ready = expectation(description: "expected bot to be ready")
        let willDiscoverPeers = redundant(expectation(description: "expected peer discovery to begin"))
        let willRefresh = redundant(expectation(description: "expected to see refresh"))
        let cancelled = expectation(description: "expected cancellation")
        let peerDiscoveryComplete = redundant(expectation(description: "expected peer discovery to complete"))
        let refreshComplete = redundant(expectation(description: "expected peer discovery to complete"))
        let noFail = inverted(expectation(description: "unexpected failure"))

        let bot = ScuttleBot()

        DispatchQueue.main.asyncAfter(deadline: cancelTime) {
            bot.cancel()
        }

        let activitySink = bot.activity.sink { status in
            switch status {
                case .ready: ready.fulfill()
                case .willDiscoverPeers: willDiscoverPeers.fulfill()
                case .peerDiscoveryComplete(_): peerDiscoveryComplete.fulfill()
                case .willRefresh: willRefresh.fulfill()
                case .cancelled: cancelled.fulfill()
                case .refreshComplete(_): refreshComplete.fulfill()
                case .failed(_): noFail.fulfill()
            }
        }
        
        defer {
            activitySink.cancel()
        }

        for _ in 1...refreshRepeatCount {
            bot.refresh(from: DispatchQueue.global(qos: .background))
        }

        waitForExpectations(timeout: testDeadline, handler: nil)
    }

    static var allTests = [
        ("test settng up a bot (complete setup)", testCompleteSetup),
    ]

}
