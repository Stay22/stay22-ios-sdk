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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.6.0-rc.1/Stay22SDK.xcframework.zip",
            checksum: "d1d40e2b10b1dd27dbc16b4ee2da71309230fb273b9f14b5c357da514d6c2dd7"
        )
    ]
)
