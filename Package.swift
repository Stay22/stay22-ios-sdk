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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.0.9/Stay22SDK.xcframework.zip",
            checksum: "7f349506a30815ba77d3e1be406f61807c64ad23a2d97dad8b22e9838f4e198f"
        )
    ]
)
