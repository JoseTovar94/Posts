//
//  APIRequestParams.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import Foundation

struct APIRequestParams {
    
    struct Home: Codable {
    }
    
    struct Detail: Codable {
        var id: Int
        private enum CodingKeys: String, CodingKey {
            case id = "postId"
        }
    }
}
