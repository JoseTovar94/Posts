//
//  StandError.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import Foundation

struct StandError: Codable {
    var error: ErrorObject
    
    struct ErrorObject: Codable {
        var code: String?
        var message: String?
        var title: String?
        var detail: String?
    }
    
    func toError() -> Error {
        let userInfo = [
            ErrorUserInfoKey.code: error.code,
            ErrorUserInfoKey.message: error.message,
            ErrorUserInfoKey.title: error.title,
            ErrorUserInfoKey.detail: error.detail
        ]
        let error = NSError(
            domain: "com.jose.tovar",
            code: 0,
            userInfo: userInfo as [String: Any]
        )
        return error
    }
}

