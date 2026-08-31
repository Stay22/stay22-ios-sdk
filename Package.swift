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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.1.0/Stay22SDK.xcframework.zip",
            checksum: "0b8a32133c00f7989f15540f0fdac08b0ee2e26539c971ba841b113cf7838bbb"
        )
    ]
)
