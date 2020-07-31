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
        // TODO...
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
