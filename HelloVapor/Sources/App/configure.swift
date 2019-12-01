import FluentSQLite
import Vapor
import VaporMonitoring

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Without specifying the hostname as 0.0.0.0, Vapor appears to only
    // allow local connections. This actually would be a nice way to
    // force' the connection to come through nginx, if that was working.
    var serverConfig = NIOServerConfig.default()
    serverConfig.hostname = "0.0.0.0"
    #if os(macOS)
        serverConfig.port = 6100
    #endif
    services.register(serverConfig)

    // Register providers first
    try services.register(FluentSQLiteProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    let prometheusService = VaporPrometheus(router: router, services: &services, route: "metrics")
    services.register(prometheusService)
    services.register(MetricsMiddleware(), as: MetricsMiddleware.self)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(MetricsMiddleware.self)
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .sqlite)
    services.register(migrations)
}
