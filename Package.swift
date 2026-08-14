// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "MeetKeyboardManager",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MeetKeyboardManager",
            targets: ["MeetKeyboardManager"]
        )
    ],
    targets: [
        .target(
            name: "MeetKeyboardManager",
            path: "MeetKeyboardManager"
        )
    ]
)
