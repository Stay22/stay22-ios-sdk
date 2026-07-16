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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.0.11/Stay22SDK.xcframework.zip",
            checksum: "ca011a0505dd848a3913908aacbbcc6138dc97ff6f216c1b76d84f602b18608f"
        )
    ]
)
