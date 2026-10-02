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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.6.1-rc.1/Stay22SDK.xcframework.zip",
            checksum: "ad9ef845bc0a9cbb1d762ed1ecd843cd02826950e9be9e6ca327fe612b6ccf45"
        )
    ]
)
