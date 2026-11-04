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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.7.0-rc.1/Stay22SDK.xcframework.zip",
            checksum: "5269e146d4b436bb0ade3074022dec8c74da9d2e5d0c6ea7fe8c27ec1447d8f8"
        )
    ]
)
