// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pixela",
    products: [
        .library(
            name: "Pixela",
            targets: ["Pixela"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ishkawa/APIKit", from: "5.1.0"),
    ],
    targets: [
        .target(
            name: "Pixela",
            dependencies: ["APIKit"]),
        .testTarget(
            name: "PixelaTests",
            dependencies: ["Pixela"]),
    ]
)
