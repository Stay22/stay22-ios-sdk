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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.6.5-rc.1/Stay22SDK.xcframework.zip",
            checksum: "09fa15934972edec600b4edbf2677c9be0f329973ac25f85a055d281da70d1c0"
        )
    ]
)
