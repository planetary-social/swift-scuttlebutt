/// ...
extension ScuttleBot {

    /// ...
    public struct ActivityCallbackPhases {

        /// ...
        public enum Status: CaseIterable {

            case ready
            case willDiscoverPeers
            case willRefresh
            case cancelled

        }

        /// ...
        public enum Report: CaseIterable {

            case peerDiscoveryComplete
            case refreshComplete

        }

        /// No constructor!
        /// This is just a namespace.
        private init() { }

    }

}
