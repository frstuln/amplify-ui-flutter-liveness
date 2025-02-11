// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rekognition_face_liveness",
    platforms: [
        // If your plugin only supports iOS, remove `.macOS(...)`.
        // If your plugin only supports macOS, remove `.iOS(...)`.
        .iOS("14.0"),
    ],
    products: [
        // If the plugin name contains "_", replace with "-" for the library name.
        .library(name: "rekognition-face-liveness", targets: ["rekognition_face_liveness"])
    ],
    dependencies: [
        .package(url: "https://github.com/aws-amplify/amplify-swift", from: "2.3.1"),
        .package(url: "https://github.com/aws-amplify/amplify-ui-swift-liveness", from: "1.3.4")
    ],
    targets: [
        .target(
            name: "rekognition_face_liveness",
            dependencies: [
                .product(name: "Amplify", package: "amplify-swift"),
                .product(name: "AWSCognitoAuthPlugin", package: "amplify-swift"),
                .product(name: "FaceLiveness", package: "amplify-ui-swift-liveness")
            ],
            resources: []
        )
    ]
)
