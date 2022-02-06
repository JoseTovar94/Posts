//
//  Detail.swift
//  posts
//
//  Created by Jose Tovar on 5/02/22.
//

import Foundation

struct Comments: Codable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    var body: String?
}
