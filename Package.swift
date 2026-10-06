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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.6.3-rc.1/Stay22SDK.xcframework.zip",
            checksum: "72381f470f6c001c1d18ffd66473bf1a5df64eb70308146b46a48451160327d5"
        )
    ]
)
