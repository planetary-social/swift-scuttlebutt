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
   let bot = ScuttleBot() {
       print("Yay, the bot is ready to scuttle!")
   } willBeginPeerDiscovery: {
	   print("About to announce presence and search for peers...")
   } discoveryComplete: { report in
       print("Discovery complete: \(report.stats);")
       print(report.malfunctions.isEmpty 
             ? "detected malfunctions: \(report.malfunctions)"
             : "all smooth!")
   } willRefresh: {
	   print("About to start refreshing...")
   } refreshComplete: { report in
       // Bot just finished another cycle and is letting you know how it went...
       print("Refresh cycle complete: \(report.stats)")
       print(report.malfunctions.isEmpty 
             ? "detected malfunctions: \(report.malfunctions);"
             : "all smooth!")
   } cancelled: {
	   print("The bot has been gracefully switched off.")
   } failed: { error in
       print("OOOOPS! SOMETHING BAD HAPPENED WITH THE BOT!" )
       print("Cause: \(error)")
   }
   ```

   - [ ] TODO: What are the defaults?
   - [ ] TODO: Where to find information about the advanced setup?

3. Time to start:

   ```swift
   bot.start(on: .main)
   ```

   > **NOTE**
   >
   > All the callbacks will be computed on the queue specified during the `start`.

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
   ```
