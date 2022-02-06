//
//  RealmHelper.swift
//  posts
//
//  Created by Jose Tovar on 5/02/22.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static let sharedInstance = RealmHelper()
    
    private init(){}
    
    func getObject()->[PostViewModel] {
        do {
            let realm = try Realm()
            return Array(realm.objects(PostViewModel.self))
        }catch let error as NSError {
            print("Error getObject  \(error)" )
        }
        return []
    }
    
    func deleteAllObject() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        }catch let error as NSError {
            print("Error deleteAllObject \(error)")
        }
    }
    
    func addObject(postViewModel: [PostViewModel]){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(postViewModel)
            }
        }catch let error as NSError {
            print("Error addObject  \(error)")
        }
    }
    
    func postUpdate(postViewModel: PostViewModel, isFavorite: Bool = false, updateFavorite: Bool = false) {
        let dbRealm = getObject()
        if let list = dbRealm.filter({ $0.id == postViewModel.id}).first {
            if updateFavorite {
                savePostFavorite(postViewModel: list, isFavorite: isFavorite)
            } else {
                savePostRead(postViewModel: list)
            }
        }
    }
    
    func savePostRead(postViewModel: PostViewModel){
        do {
            let realm = try Realm()
            
            try realm.write {
                postViewModel.isRead = true
            }
        }catch let error as NSError {
            print("Error addObject  \(error)")
        }
    }
    
    
    func savePostFavorite(postViewModel: PostViewModel, isFavorite: Bool){
        do {
            let realm = try Realm()
            
            try realm.write {
                postViewModel.isFavorite = isFavorite
            }
        }catch let error as NSError {
            print("Error addObject  \(error)")
        }
    }
    
    func deletePost(postViewModel: PostViewModel) {
        let dbRealm = getObject()
        if let list = dbRealm.filter({ $0.id == postViewModel.id}).first {
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.delete(list)
                }
            }catch let error as NSError {
                print("Error addObject  \(error)")
            }
        }
    }
    
}
