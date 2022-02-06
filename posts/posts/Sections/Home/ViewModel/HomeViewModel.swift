//
//  HomeViewModel.swift
//  posts
//
//  Created by Jose Tovar on 5/02/22.
//

import Foundation
import RealmSwift


class PostViewModel:  Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    @objc dynamic var isFavorite = false
    @objc dynamic var isRead = false
    
    init(id: Int, title: String, body: String, isFavorite: Bool, isRead: Bool){
        self.id = id
        self.title = title
        self.body = body
        self.isFavorite = isFavorite
        self.isRead = isRead
    }
    
    override init() {}
    
}
