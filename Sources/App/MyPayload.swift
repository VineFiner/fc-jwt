//
//  File.swift
//  
//
//  Created by Finer  Vine on 2023/3/18.
//

import Foundation
import JWT

// JWT payload 结构。
struct MyPayload: JWTPayload {
    // 将较长的 Swift 属性名称映射到 JWT payload 中使用的缩写密钥。
    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case isAdmin = "admin"
    }

    // "sub" (主题) 声明标识了作为 JWT 主题的主体。
    var subject: SubjectClaim

    // “exp” (过期时间) 声明标识了过期时间，过期后 JWT 绝对不能被接受处理。
    var expiration: ExpirationClaim

    // 自定义数据。
    // 如果为真，则该用户为管理员。
    var isAdmin: Bool

    // 在这里运行额外的签名验证逻辑。
    // 因为我们有 ExpirationClaim，我们将调用其 verify 方法。
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
}
