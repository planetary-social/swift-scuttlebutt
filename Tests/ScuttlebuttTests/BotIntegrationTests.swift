import XCTest

@testable import Scuttlebutt

final class BotIntegrationTests: XCTestCase {

    private func redundantExpectation(description: String) -> XCTestExpectation {
        let e = expectation(description: description)
        e.assertForOverFulfill = false
        return e
    }
    
    func testCompleteSetup() {
        let refreshRepeatCount = Int.random(in: 5...10)
        let testDeadline: TimeInterval = 5
        let cancelTime: DispatchTime = .now() + 4

        let statusExpectations: [ScuttleBot.Phase.Status: XCTestExpectation] = [
            .ready: expectation(description: "expected bot to be ready"),
            .willDiscoverPeers: redundantExpectation(description: "expected peer discovery to begin"),
            .willRefresh: redundantExpectation(description: "expected to see refresh"),
            .cancelled: expectation(description: "expected cancellation"),
        ]

        let reportExpectations: [ScuttleBot.Phase.Report: XCTestExpectation] = [
            .peerDiscoveryComplete: redundantExpectation(description: "expected peer discovery to complete"),
            .refreshComplete: redundantExpectation(description: "expected peer discovery to complete"),
        ]

        var noFail = expectation(description: "unexpected failure")
        noFail.isInverted = true

        let bot = ScuttleBot {
            statusExpectations[.ready]!.fulfill()
        } willDiscoverPeers: {
            statusExpectations[.willDiscoverPeers]!.fulfill()
        } peerDiscoveryComplete: { report in
            reportExpectations[.peerDiscoveryComplete]!.fulfill()
        } willRefresh: {
            statusExpectations[.willRefresh]!.fulfill()
        } refreshComplete: { report in
            reportExpectations[.refreshComplete]!.fulfill()
        } cancelled: {
            statusExpectations[.cancelled]!.fulfill()
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
