import Combine
import Foundation
import PeerDiscovery
import Wiggling
import WigglingBonjour
import WigglingNetworkMulticast

/// ...
@available(OSX 10.15, *)
public class ScuttleBot: Cancellable {
    
    /// ...
    private typealias Discovery = WigglingSession<Peer>
    
    /// ...
    private typealias Gossiping = GossipSession<Peer>
    
    /// ...
    private typealias Scheduler = PeerToPeerNetworkingQueue<Peer>

    ///
    public let activity = PassthroughSubject<Activity, Never>()

    ///
    public var isReady: Bool = false
    
    /// ...
    private let discovery: Discovery

    /// ...
    private let gossiping: Gossiping

    /// ...
    private let scheduler: Scheduler

    /// ...
    private let reporting: [AnyCancellable]

    /// ...
    public init() {
        discovery = Discovery(using: [
            .bonjour(
                /* FIXME: Configure! */
            ),
            // FIXME: Platform version constraints for the multicast
            .networkMulticast(
                /* FIXME: Configure! */
            ),
        ])

        gossiping = Gossiping(
            /* FIXME: Configure! Pass reference to GoBot */
        )
        
        scheduler = Scheduler(
            /* FIXME: Configure! */
        )
        
        reporting = [
            scheduler.activity.sink(schedulerDidReport),
            gossiping.activity.sink(gossipingDidReport),
            discovery.activity.sink(discoveryDidReport),
        ]

        scheduler.suggestions.subscribe(discovery.discoveries)
        scheduler.suggestions.subscribe(gossiping.suggestions)
        gossiping.connections.subscribe(scheduler.connections)
        discovery.suggestions.subscribe(scheduler.adaptations)

        // TODO: Subscribe to discovery, gossiping, and scheduler activities.
        
        // TODO: Configure scheduler's persistent storage.
        
        // TODO: Implement so that GoBot cane wrapped or extended without disrupting the API too much.
    }

    /// ...
    public func refresh(from queue: DispatchQueue) {
        // TODO

        if !isReady {
            activity.send(.ready)
            isReady = true // TODO: Remove this...
        }

        // TODO: Use the queue...
        
        activity.send(.willDiscoverPeers)
        activity.send(.peerDiscoveryComplete(Activity.Stats()))
        activity.send(.willRefresh)
        activity.send(.refreshComplete(Activity.Stats()))

        // FIXME: Move all above appropriately.
    }

    // ...
    private func discoveryDidReport(activity: Discovery.Activity) {
        // TODO
    }

    // ...
    private func gossipingDidReport(activity: Gossiping.Activity) {
        // TODO
    }

    // ...
    private func schedulerDidReport(activity: Scheduler.Activity) {
        // TODO
    }
    
    /// ...
    public func cancel() {
        // TODO

        isReady = false // TODO: Remove this too...
        
        // TODO: cancel reporting?
        
        activity.send(.cancelled)
    }

}
