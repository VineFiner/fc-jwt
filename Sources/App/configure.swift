import Leaf
import JWT
import Vapor
import Foundation

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)
    
    let resources = app.directory.resourcesDirectory
    // 使用私有 pem 初始化 RSA 密钥。
    let rsaPrivateKey = try String(contentsOfFile: "\(resources)/JWTSigners/rsaPrivateKey.txt", encoding: .utf8)
    let privateKey = try RSAKey.private(pem: rsaPrivateKey)
    // 添加带有 SHA-256 的 RSA 算法的签名者。
    app.jwt.signers.use(.rs256(key: privateKey))
    
    // 下载 JWKS.
    let jwksData = try Data(
        contentsOf: URL(fileURLWithPath: "\(resources)/JWTSigners/jwks.json")
    )
    let jwks = try JSONDecoder().decode(JWKS.self, from: jwksData)
    // Create signers and add JWKS.
    try app.jwt.signers.use(jwks: jwks)
    
    // register routes
    try routes(app)
}
