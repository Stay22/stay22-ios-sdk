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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.3.0/Stay22SDK.xcframework.zip",
            checksum: "05c0e0293201f725f437bbb33ce295cca3913c72e43d9f767e884638e6a220ab"
        )
    ]
)
