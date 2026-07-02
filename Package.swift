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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.0.10/Stay22SDK.xcframework.zip",
            checksum: "956c4d89de0118cea77fde27c30f929539e3d5ac8268332c60b634c3988a4920"
        )
    ]
)
