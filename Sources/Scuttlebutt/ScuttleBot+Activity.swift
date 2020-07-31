/// ...
@available(OSX 10.15, *)
extension ScuttleBot {

    /// ...
    public enum Activity {

        case ready
        case willDiscoverPeers
        case peerDiscoveryComplete(Stats)
        case willRefresh
        case cancelled
        case refreshComplete(Stats)
        case failed(Error)

    }

}
