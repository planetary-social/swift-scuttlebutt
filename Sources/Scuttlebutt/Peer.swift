public extension Scuttlebutt {

    /// ...
    struct Peer {
        
        /// ...
        let identity: Identity
        
        /// ...
        var displayName: String?
        
        /// ...
        var localNetworkEndpoints: [Endpoint]
        
        /// ...
        typealias Endpoint = (resolved: Network.ResolvedEndpoint,
                              handshakeChoice: Handshake)
        
    }
    
}
