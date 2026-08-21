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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.0.12/Stay22SDK.xcframework.zip",
            checksum: "137fdc8f467149a039dddbd11905c5175304eb674e2d8077fab3d86006bf0a37"
        )
    ]
)
