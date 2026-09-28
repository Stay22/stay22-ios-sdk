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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.5.0-rc.1/Stay22SDK.xcframework.zip",
            checksum: "7777c4d46599401437656a0dea446b8574347caa1dc83fcfc78c4f1256d753d5"
        )
    ]
)
