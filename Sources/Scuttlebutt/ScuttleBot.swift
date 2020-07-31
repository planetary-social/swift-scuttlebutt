import Combine
import Foundation

/// ...
@available(OSX 10.15, *)
public class ScuttleBot: Cancellable {

    ///
    public let activity = PassthroughSubject<Activity, Never>()

    ///
    public var isReady: Bool = false
    
    
    /// ...
    public init() {
        
        // TODO: Implement so that GoBot cane wrapped or extended without disrupting the API too much.
    }

    /// ...
    public func refresh() {
        // TODO

        if !isReady {
            activity.send(.ready)
            isReady = true // TODO: Remove this...
        }

        activity.send(.willDiscoverPeers)
        activity.send(.peerDiscoveryComplete(Activity.Stats()))
        activity.send(.willRefresh)
        activity.send(.refreshComplete(Activity.Stats()))

        // FIXME: Move all above appropriately.
    }
    
    // TODO: Add refresh(from:)

    /// ...
    public func cancel() {
        // TODO

        isReady = false // TODO: Remove this too...
        
        activity.send(.cancelled)
    }

}
