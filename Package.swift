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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/3.0.1/Stay22SDK.xcframework.zip",
            checksum: "aab231cb4a6363e1fbacbb2a21e84dac86be306eba1d4f53cbddd9f07ecb0a60"
        )
    ]
)
