// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "swift-scuttlebutt",
    // TODO: What are the supported platforms?
    products: [
        .library(
            name: "Scuttlebutt",
            targets: ["Scuttlebutt"]),
    ],
    dependencies: [
        .package(path: "../swift-gossip"),
        .package(path: "../swift-peer-discovery"),
        .package(path: "../swift-networking-schedule"),
    ],
    targets: [
        .target(
            name: "Scuttlebutt",
            dependencies: []),
        .testTarget(
            name: "ScuttlebuttTests",
            dependencies: ["Scuttlebutt"]),
    ]
)
