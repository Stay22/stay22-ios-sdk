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
            url: "https://github.com/Stay22/stay22-ios-sdk/releases/download/1.6.2/Stay22SDK.xcframework.zip",
            checksum: "b6203e0511d24a241a1e783343c909608fe4555eeef720305f4177e53cc276d8"
        )
    ]
)
