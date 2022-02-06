//
//  Post.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import Foundation

struct Post: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    var isFavorite: Bool?
    var isRead: Bool?
}
