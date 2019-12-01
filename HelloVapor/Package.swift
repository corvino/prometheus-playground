// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Hello",
    products: [
        .library(name: "Hello", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),

        .package(url: "https://github.com/corvino/VaporMonitoring.git", .revision("c8fb338835efe6f11125e9a528b553b86d03b452"))
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "VaporMonitoring"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
