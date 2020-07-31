import XCTest

@testable import Scuttlebutt

final class BotIntegrationTests: XCTestCase {

    func testCompleteSetup() {
        let refreshRepeatCount = Int.random(in: 5...10)
        let testDeadline: TimeInterval = 5
        let cancelTime: DispatchTime = .now() + 4

        let ready = expectation(description: "expected ready")

        var willBeginPeerDiscovery = expectation(description: "expected peer discovery to begin")
        willBeginPeerDiscovery.assertForOverFulfill = false

        var discoveryComplete = expectation(description: "expected peer discovery to complete")
        discoveryComplete.assertForOverFulfill = false

        var willRefresh = expectation(description: "expected to see refresh")
        willRefresh.assertForOverFulfill = false

        var refreshComplete = expectation(description: "expected refresh to complete")
        refreshComplete.assertForOverFulfill = false

        let cancelled = expectation(description: "expected cancellation")

        var noFail = expectation(description: "unexpected failure")
        noFail.isInverted = true

        let bot = ScuttleBot() {
            ready.fulfill()
        } willBeginPeerDiscovery: {
            willBeginPeerDiscovery.fulfill()
        } discoveryComplete: { report in
            discoveryComplete.fulfill()
        } willRefresh: {
            willRefresh.fulfill()
        } refreshComplete: { report in
            refreshComplete.fulfill()
        } cancelled: {
            cancelled.fulfill()
        } failed: { error in
            noFail.fulfill()
        }

        bot.start(queue: .main)

        for _ in 1...refreshRepeatCount {
            bot.refresh()
        }

        DispatchQueue.main.asyncAfter(deadline: cancelTime) {
            bot.cancel()
        }

        waitForExpectations(timeout: testDeadline, handler: nil)
    }

    static var allTests = [
        ("test settng up a bot (complete setup)", testCompleteSetup),
    ]

}
