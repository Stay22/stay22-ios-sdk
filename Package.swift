// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Stay22SDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "Stay22SDK", targets: ["Stay22SDK"])
    ],
    targets: [
        .binaryTarget(
            name: "Stay22SDK",
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.6.4-rc.1/Stay22SDK.xcframework.zip",
            checksum: "5dcf93c06c72db2e82f5c417773b80f8ea46b25f3d5efb3961f7e8a6c82335d5"
        )
    ]
)
