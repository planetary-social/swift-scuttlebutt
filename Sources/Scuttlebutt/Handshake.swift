/// ...
public extension Scuttlebutt {
    
    /// ...
    enum Handshake: String, CustomStringConvertible {

        /// ...
        case secret = "shs"
        
        /// ...
        public var description: String {
            switch self {
            case .secret:
                return "Secret Handshake"
            }
        }
        
    }
    
}
