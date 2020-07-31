/// ...
extension ScuttleBot {

    /// ...
    public struct ActivityCallbacks {

        public typealias Status = () -> Void
        public typealias Report = (ActivityStats) -> Void

        /// No constructor!
        /// This is just a namespace.
        private init() { }

    }

}
