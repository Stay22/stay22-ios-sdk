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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/3.1.0-rc.1/Stay22SDK.xcframework.zip",
            checksum: "bedd63246e4484288afef3c49d0be9e89f995653efb27f9099b660e0cbbf83c8"
        )
    ]
)
