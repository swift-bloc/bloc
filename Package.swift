// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bloc",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Bloc",
            targets: ["Bloc"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-docc-plugin",
            from: "1.3.0"
        )
    ],
    targets: [
        .target(
            name: "Bloc"
        ),
        .testTarget(
            name: "BlocTests",
            dependencies: ["Bloc"]
        )
    ]
)
