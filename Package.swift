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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.4.0/Stay22SDK.xcframework.zip",
            checksum: "d4b39391cc73faabb2fcd0d52d6769b53be9e6669e69d255117eb7723560cf1d"
        )
    ]
)
