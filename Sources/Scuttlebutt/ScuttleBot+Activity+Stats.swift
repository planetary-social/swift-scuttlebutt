import Foundation

// FIXME: This are stubs, parts should be probably moved to more abstract places and reused in other packages.
// Specifically: ProcessingPowerConsumption, DataTansfer...

/// ...
@available(OSX 10.15, *)
extension ScuttleBot.Activity {

    /// ...
    public struct Stats {

        /// ...
        public typealias Count = UInt

        /// ...
        public struct EnergyConsumption {

            /// ...
            public var interval: TimeInterval

            /// ...
            public var tasks: Count

        }

        /// ...
        public struct EnergyBudget {
            
            /// ...
            public let used, wasted: EnergyConsumption

        }

        /// ...
        public struct PeerOutreach {

            /// ...
            public var seen, ignored, suggested, adapted: Count

        }

        /// ...
        public struct DataTransferConsumption {

            /// ...
            public let attempted, sent, received, corrupted: Count

            /// ...
            public var total: (read: Count, lost: Count) {
                (read: sent + received,
                 lost: attempted - sent + (received - corrupted))
            }

        }

        /// ...
        public struct DataTransfer {

            /// ...
            public let bytes, packets: DataTransferConsumption

        }
        
        /// ...
        public var scheduling: Scheduling
        
        /// ...
        public struct Scheduling {

            /// ...
            public var energyBudget: EnergyBudget

            // TODO: Calculate scheduling success rate....
            
        }

        /// ...
        public var networking: Networking

        /// ...
        public struct Networking {

            /// ...
            public var energyBudget: EnergyBudget

            /// ...
            public var peerOutreach: PeerOutreach

            /// ...
            public var dataTransfer: DataTransfer

        }

    }

}
