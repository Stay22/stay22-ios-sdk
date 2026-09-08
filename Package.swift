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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.2.0/Stay22SDK.xcframework.zip",
            checksum: "c59a8eb810a5ab6836d0926220684fbc057c5783a3d820588adc1ddcbcafc070"
        )
    ]
)
