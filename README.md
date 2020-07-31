# Swift Scuttlebutt

**How to participate in Scuttlebutt from Swift Programs?**

- [ ] TODO: Abstract.

## Getting Started

- [ ] TODO: What are the requirements?
- [ ] TODO: How to install this thing?

## Letting the Bot Scuttle

1. Bring the library to your project:

   ```swift
   import Scuttlebutt
   ```

2. Set up your bot:


   ```swift
   let bot = ScuttleBot()
   ```
   
   - [ ] TODO: What are the defaults?
   - [ ] TODO: Where to find information about the advanced setup?

3. Subscribe to status updates:

   ```swift
   let activitySubscription = bot.activity.sink { status in
        switch status {
        case .ready: 
            print("Yay, the bot is ready to scuttle!")
        case .willDiscoverPeers:
            print("About to announce presence and search for peers...")
        case .peerDiscoveryComplete(let stats):
            print("Peer discovery complete: \(stats);")
        case .willRefresh:
            print("About to refresh...")
        case .refreshComplete(let stats):
            print("Refresh cycle complete: \(stats)")
        case .cancelled:
            print("The bot has been gracefully switched off.")
        case .failed(let error):
            print("OOOOPS! SOMETHING BAD HAPPENED WITH THE BOT!" )
            print("Cause: \(error)")
        }
   }
   ```

4. Refresh at will:

   ```swift
   bot.refresh(from: .background)
   ```

   > **NOTE**
   >
   > Calling `refresh` multiple times one after another **will not** schedule that amount of refresh operations.
   > In order to provide maximum level of consistency, the actual execution of operations is scheduled adaptively, by the bot itself.
   > The effective configuration of the next refresh largly depends on the receiver's quality of service class; 
   > for example: a `userInitiated` refresh will be executed as soon as possible, while the one scheduled from the `background` will be deferred until the most opportune moment.

   - [ ] TODO: Where to find more about scheduling?

5. Cancel whenever ready to terminate you application:

   ```swift
   bot.cancel()
   activitySubscription.cancel()
   ```

   > **CAUTION**
   >
   > Don't forget that the caller is responsivle for cancelling the subscription. 
