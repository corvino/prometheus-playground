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

//        // Ugh. Take one.
//        // This is a mess. It pulls in Kitura? Really?
//        // log conflics with log (vapor and apple).
//        // And it is using SwiftyJson, which I can't get to work. And is stupid.
//        // https://forums.swift.org/t/logging-module-name-clash-in-vapor-3/25466
//        .package(url: "https://github.com/IBM-Swift/LoggerAPI.git", .upToNextMinor(from: "1.8.0")),
//        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),
//        .package(url: "https://github.com/vapor-community/VaporMonitoring.git", from: "1.0.0")
//
//        // Take two.
//        // It turns out no changes are needed; but you did need to point at the right branch of the right for.
//        .package(url: "file:///Users/vino/code/opensource/VaporMonitoring", .branch("corvino-cleanup"))

        // This cleans up things significantly. Packes are less, request metrics are gathered in a middleware,
        // and it removes the custom dashboard displayed from Vapor. All we want is Prometheus metrics!
        .package(url: "https://github.com/Yasumoto/VaporMonitoring.git", .branch("yasumoto-middleware-approach"))
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "VaporMonitoring"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

