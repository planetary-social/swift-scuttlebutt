import Combine

/// ...
public class ScuttleBot: Cancellable {

    /// In context of the bot, when we talk about phases, it means we talk about the activity callback phases.
    public typealias Phase = ActivityCallbackPhases
    
    /// The same reference to activity is true when talking about callbacks.
    public typealias Callback = ActivityCallbacks

    /// ...
    public init(_ ready: Callback.Status? = nil,
                willDiscoverPeers: Callback.Status? = nil,
                peerDiscoveryComplete: Callback.Report? = nil,
                willRefresh: Callback.Status? = nil,
                refreshComplete: Callback.Report? = nil,
                cancelled: Callback.Status? = nil,
                failed: ((Error) -> Void)? = nil) {
        // TODO: Implement so that GoBot cane wrapped or extended without disrupting the API too much.
    }

    public func cancel() {
        // TODO
    }

}
