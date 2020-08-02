import XCTest

import PeerDiscovery
import MulticastGroupNetworkPeerDiscovery

@testable import Scuttlebutt

final class PeerMulticastGroupNetworkDiscoverabilityTests: XCTestCase {

    /// ...
    var exampleIdentifiersPool: [String] = [
        "FCX/tsDLpubCPKKfIrw4gc+SQkHcaD17s7GI6i/ziWY=",
        // TODO: Add a variety of example identies...
    ]
    
    /// ...
    let exampleEndpoint: Scuttlebutt.Network.ResolvedEndpoint =
        (address: "192.168.0.101", port: 8008)
    
    /// ...
    func testReadingSimpleAnnouncement() {
        let endpoint = exampleEndpoint
        let publicIdentifier = exampleIdentifiersPool.randomElement()!
        let announcement = "net:\(endpoint.address):\(endpoint.port)~shs:\(publicIdentifier)"
        let maybePeer = Scuttlebutt.Peer.decode(fromMulticast: announcement)

        guard let peer = maybePeer else {
            XCTFail("failed to parse multicast peer announcement")
            return
        }
        
        XCTAssertEqual(peer.identity.description, publicIdentifier)
        XCTAssertEqual(peer.localNetworkEndpoints.count, 1)
        XCTAssertEqual(peer.multicastNetworkPresenceAnnouncement!, announcement)

        let resolving = peer.localNetworkEndpoints[0].resolved
        let handshake = peer.localNetworkEndpoints[0].handshakeChoice

        XCTAssertEqual(resolving.address, endpoint.address)
        XCTAssertEqual(resolving.port, endpoint.port)
        XCTAssertEqual(handshake, .secret)
    }

    /// ...
    func testReadingMultiEndpointAnnouncement() {
        let publicIdentifier = exampleIdentifiersPool.randomElement()!
        let sampleSize = Int.random(in: 3...6)

        let endpoints: [Scuttlebutt.Network.ResolvedEndpoint] =
            (101...(100 + sampleSize)).map { n in
                return (address: "192.168.0.\(n)", port: exampleEndpoint.port)
            }

        let announcements: [String] =
            endpoints.map { endpoint in
                return "net:\(endpoint.address):\(endpoint.port)~shs:\(publicIdentifier)"
            }

        let peers: [Scuttlebutt.Peer] =
            announcements.compactMap(Scuttlebutt.Peer.decode(fromMulticast:))

        XCTAssertEqual(peers.count, sampleSize)
    }
    
    /// ...
    func testReadingFailureIfOnlyCorruptedAnnouncement() {
        XCTAssertNil(Scuttlebutt.Peer.decode(fromMulticast: "single-corrupted-announcement"))
    }
    
    /// ...
    func testReadingGracefullyIgnoringCorruptedAnnouncementsSurplus() {
        let endpoint = exampleEndpoint
        let publicIdentifier = exampleIdentifiersPool.randomElement()!
        let validAnnouncement = "net:\(endpoint.address):\(endpoint.port)~shs:\(publicIdentifier)"

        let announcements: [String] = [
            validAnnouncement,
            "unknown-transport:\(endpoint.address):\(endpoint.port)~shs:\(publicIdentifier)",
            "net:\(endpoint.address):\(endpoint.port)~absolutely-invalid-handshake",
            "net:\(endpoint.address):9999999999999~shs:\(publicIdentifier)",
            "net:\(endpoint.address):no-port~shs:\(publicIdentifier)",
            // TODO: Add variants for invalid IP address...
            "net:invalid-address~shs:\(publicIdentifier)",
            "net:totally-unsupported-announcement",
            "another-absurd-announcement",
        ]

        guard let peer = Scuttlebutt.Peer.decode(fromMulticast: announcements.joined(separator: ";")) else {
            XCTFail("expected to gracefully ignore corrupted surplus of announcements")
            return
        }

        XCTAssertEqual(peer.identity.description, publicIdentifier)
    }

    static var allTests = [
        ("test reading multicast peer announcement (simple)",
         testReadingSimpleAnnouncement),
        ("test reading multicast peer announcement (multiple endpoints)",
         testReadingMultiEndpointAnnouncement),
        ("test reading multicast peer announcement (failing with single corrupted)",
         testReadingFailureIfOnlyCorruptedAnnouncement),
        ("test reading multicast peer announcement (gracefully ignoring corrupted surplus)",
         testReadingGracefullyIgnoringCorruptedAnnouncementsSurplus),
    ]

}
