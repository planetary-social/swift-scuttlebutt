import XCTest

@testable import Scuttlebutt

@available(OSX 10.15, *)
final class NetworkAddressingTests: XCTestCase {

    func testAvailableAddressesRetrieval() {
        let available = Scuttlebutt.Network.availableAddresses

        XCTAssert(available.contains("127.0.0.1"))
        XCTAssert(available.contains("::1"))
    }
    
    func testBestAddressesChoice() {
        let chosen = Scuttlebutt.Network.bestAddresses
        
        XCTAssert(chosen.count == 2)

        if chosen[0].contains(":") {
            XCTAssert(chosen[1].contains("."), "Best fallback address is not an IPv4!")
        } else {
            XCTAssert(chosen[0].contains("."), "Best selected address is not an IPv4 (in absence of IPv6)!")
        }
        
        for address in chosen {
            XCTAssertFalse(Scuttlebutt.Network.ignoredLocalAddresses.contains(address))
        }
    }

    static var allTests = [
        ("test retrieval of all available network addresses", testAvailableAddressesRetrieval),
        ("test the choice of best binding addresses", testBestAddressesChoice),
    ]

}
