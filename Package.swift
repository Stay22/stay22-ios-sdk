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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.0.8/Stay22SDK.xcframework.zip",
            checksum: "34e029869e4f5f48096f923e8d71e7cb2973671a2db8f5c8205330167e82de45"
        )
    ]
)
