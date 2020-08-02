import Foundation

/// ...
public extension Scuttlebutt.Peer {

    /// ...
    enum Identity: CustomStringConvertible {

        /// ...
        case ed25519(publicKey: Data, secretKey: Data?)

        /// ...
        public var description: String {
            switch self {
            case .ed25519(let publicKey, _):
                return publicKey.base64EncodedString()
            }
        }

    }

}
