import Darwin

/// ...
public extension Scuttlebutt.Network {
    
    /// ...
    typealias Address = String
    
    /// ...
    static var availableAddresses: [Address] {
        // XXX: ...
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        guard getifaddrs(&ifaddr) == 0 else {
            // FIXME: Log error!
            return []
        }
        
        guard let addr = ifaddr else {
            // FIXME: Log error!
            return []
        }
        
        defer {
            freeifaddrs(ifaddr)
        }

        return
            sequence(first: addr.pointee, next: { $0.ifa_next?.pointee })
            .filter { [UInt8(AF_INET), UInt8(AF_INET6)].contains($0.ifa_addr.pointee.sa_family) }
            .compactMap { (Scuttlebutt.Network(rawValue: String(cString: $0.ifa_name)), $0) }
            .compactMap { (network, interface) in
                var hostNameBuffer = [CChar](repeating: 0, count: Int(NI_MAXHOST))

                getnameinfo(interface.ifa_addr,
                            socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostNameBuffer,
                            socklen_t(hostNameBuffer.count),
                            nil,
                            socklen_t(0),
                            NI_NUMERICHOST)

                // XXX: Does the buffer need a release, or does the GC takes over?
                return String(cString: hostNameBuffer)
            }
    }

    /// ...
    typealias Host = String

    /// ...
    typealias Port = UInt16

    /// ...
    typealias Endpoint = (host: Host, port: Port)

    /// ...
    typealias ResolvedEndpoint = (address: Address, port: Port)

}
