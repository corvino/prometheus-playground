import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    func fail(chance: Float) -> Bool {
        print("fail \(chance)")
        return Float.random(in: 0..<1) < chance
    }

    func randomAbort() -> Abort {
        switch Int.random(in: 1...3) {
        case 1: return Abort(.internalServerError)
        case 2: return Abort(.notImplemented)
        default: return Abort(.badRequest)
        }
    }

    router.get("fail30") { _ throws -> String in
        guard !fail(chance: 0.3) else { throw randomAbort() }
        return "ok"
    }

    router.get("fail60") { _ throws -> String in
        guard !fail(chance: 0.6) else { throw randomAbort() }
        return "ok"
    }

    router.get("fail90") { _ throws -> String in
        guard !fail(chance: 0.9) else { throw randomAbort() }
        return "ok"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
