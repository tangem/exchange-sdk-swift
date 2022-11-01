// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExchangeSdk",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ExchangeSdk",
            targets: [
                "ExchangeSdk",
                "ExchangeSdkTests"
            ]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", exact: Version(15, 0, 0)),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ExchangeSdk",
            dependencies: [
                .product(name: "Moya", package: "Moya"),
            ]
        ),
        .testTarget(
            name: "ExchangeSdkTests",
            dependencies: [
                "ExchangeSdk"
            ]
        ),
    ]
)
