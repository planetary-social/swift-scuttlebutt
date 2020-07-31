import Combine

/// ...
public class ScuttleBot: Cancellable {

    /// In context of the bot, when we talk about phases, it means we talk about the activity callback phases.
    public typealias Phase = ActivityCallbackPhases
    
    /// The same reference to activity is true when talking about callbacks.
    public typealias Callback = ActivityCallbacks

    /// ...
    private var statusCallbacks = [Phase.Status: Callback.Status]()

    /// ...
    private var reportCallbacks = [Phase.Report: Callback.Report]()

    /// ...
    private let didFail: ((Error) -> Void)?

    /// ...
    public init(_ ready: Callback.Status? = nil,
                willDiscoverPeers: Callback.Status? = nil,
                peerDiscoveryComplete: Callback.Report? = nil,
                willRefresh: Callback.Status? = nil,
                refreshComplete: Callback.Report? = nil,
                cancelled: Callback.Status? = nil,
                failed: ((Error) -> Void)? = nil) {
        statusCallbacks[.ready] = ready
        statusCallbacks[.willDiscoverPeers] = willDiscoverPeers
        reportCallbacks[.peerDiscoveryComplete] = peerDiscoveryComplete
        statusCallbacks[.willRefresh] = willRefresh
        reportCallbacks[.refreshComplete] = refreshComplete
        statusCallbacks[.cancelled] = cancelled

        didFail = failed
        
        // TODO: Implement so that GoBot cane wrapped or extended without disrupting the API too much.
    }

    /// ...
    public func cancel() {
        // TODO
        
        statusCallbacks[.cancelled]?()
    }

}
