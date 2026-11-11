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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/3.1.1-rc.1/Stay22SDK.xcframework.zip",
            checksum: "4f763f917791b6c6da8683882ff7ae8f16cc1358a2c6e69d46c663fe2f1caf0f"
        )
    ]
)
