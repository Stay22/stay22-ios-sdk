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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/2.0.0-rc.1/Stay22SDK.xcframework.zip",
            checksum: "1171992ce279b691481ea65b839f957ea5ed7faadc988d3c418984a7e1ee1c89"
        )
    ]
)
