/// ...
public extension Scuttlebutt {

    /// ...
    enum Network: String, CaseIterable {

        /// ...
        case wifi = "en0"
        
        /// ...
        case cell = "pdp_ip0"

        /// ...
        case ipv4, ipv6 // FIXME: These seem OSX only, but double check!!!

    }

}
