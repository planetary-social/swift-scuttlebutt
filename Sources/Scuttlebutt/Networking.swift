public extension Scuttlebutt {

    /// Scuttlebutt requires some form of networking connectivity in order to advertise peer presence or synchronize data.
    /// These are all the networking interfaces supported to various extent.
    enum Networking: String, CaseIterable {

        /// Refers to networking Wi-Fi interfaces.
        case wifi = "en0"

        /// Refers to cellular networking.
        case cell = "pdp_ip0"
        //^ FIXME: Is this iOS only?

        /// Refers to Internet Stack.
        case ipv4, ipv6
        //^ FIXME: These seem OSX specific, double check!!!

    }

}
