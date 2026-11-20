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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/3.1.2/Stay22SDK.xcframework.zip",
            checksum: "dcb3edaa80b4360a20bd7731d6b939768598eee6ff644fd123ce99c081f4efbc"
        )
    ]
)
