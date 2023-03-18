import Vapor

func routes(_ app: Application) throws {
    
    // http://127.0.0.1:8080
    app.get { req async throws in
        try await req.view.render("index.html", ["title": "Hello Vapor!"])
    }
    
    // http://127.0.0.1:8080/hello
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    // 验证 JWT
    // http://127.0.0.1:8080/api/jwt/verify
    app.get("api", "jwt", "verify") { req async throws -> MyPayload in
        // JWT进行验证
        let jwtPayload = try req.jwt.verify(as: MyPayload.self)
        req.logger.info("jwt payload:\(jwtPayload)")
        return jwtPayload
    }
    
    // 签名 JWT
    // http://127.0.0.1:8080/api/jwt/sign
    app.get("api", "jwt", "sign") { req async throws -> [String: String] in
        // 创建一个 JWTPayload 实例
        let jwtPayload = MyPayload(
            subject: "Vapor",
            expiration: .init(value: .distantFuture),
            isAdmin: true)
        
        req.logger.info("token: \(String(describing: try? req.jwt.sign(jwtPayload)))")
        // 返回签名的 JWT。
        return try [
            "token": req.jwt.sign(jwtPayload)
        ]
    }
}

extension MyPayload: Content { }
