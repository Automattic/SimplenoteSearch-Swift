// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "SimplenoteSearch",
    platforms: [.macOS(.v10_13),
                .iOS(.v11)],
    products: [
        .library(
            name: "SimplenoteSearch",
            targets: ["SimplenoteSearch"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SimplenoteSearch",
                path: "Sources/SimplenoteSearch"),
        .testTarget(name: "SimplenoteSearchTests",
                    dependencies: ["SimplenoteSearch"])
    ],
    swiftLanguageVersions: [.v5]
)
