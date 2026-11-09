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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/3.0.0/Stay22SDK.xcframework.zip",
            checksum: "bac4905cabdd0455b1738bf68e597a0392e884389e798f3e425cecf0501da319"
        )
    ]
)
