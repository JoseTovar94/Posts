//
//  HomeViewModelController.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import Foundation
import RealmSwift

protocol AsyncResponse {
    func updateUI()
}

class HomeViewModelController {
    
    // MARK: - Vars
    var postList: [PostViewModel]?
    var delegate: AsyncResponse?
    
    // MARK: - init
    func loadData(success: @escaping () -> Void, errorMessage: @escaping (String) -> Void) {
        let postList = RealmHelper.sharedInstance.getObject()
        
        if postList.isEmpty {
            loadRequets(success: {
                success()
            }, errorMessage: { (error) in
                errorMessage("Error")
            })
        } else {
            getListFromDB()
            success()
        }
    }
    
    //MARK: - request
    func loadRequets(success: @escaping () -> Void, errorMessage: @escaping (String) -> Void) {
        let apiRoute = APIRoute<APIRequestParams.Home>.Home()
        apiRoute.params = .init()
        APINetworking.request(route: apiRoute) { (response: [Post]) in
            self.postList = response.map{PostViewModel.init(id: $0.id ?? 0, title: $0.title ?? "", body: $0.body ?? "", isFavorite: false, isRead: false)}
            self.saveListToRealm()
            success()
        }onError: { (error) in
            print("Error")
        }
    }
    
    //MARK: - Database
    func saveListToRealm() {
        DispatchQueue.main.async {
            let dbRealm = RealmHelper.sharedInstance.getObject()
            if !dbRealm.isEmpty {
                RealmHelper.sharedInstance.deleteAllObject()
            }
            if let list = self.postList {
                RealmHelper.sharedInstance.addObject(postViewModel: list)
            }
        }
    }
    
    func getListFromDB() {
        let dbRealm = RealmHelper.sharedInstance.getObject()
        self.postList = dbRealm
        delegate?.updateUI()
    }
    
    func deleteListFromDB() {
        let dbRealm = RealmHelper.sharedInstance.getObject()
        if !dbRealm.isEmpty {
            RealmHelper.sharedInstance.deleteAllObject()
        }
    }
    
    //MARK: - Actions
    func postRead(post: PostViewModel) {
        RealmHelper.sharedInstance.postUpdate(postViewModel: post)
        getListFromDB()
    }
    
    func deletePost(index: Int) {
        if let list = self.postList {
            RealmHelper.sharedInstance.deletePost(postViewModel: list[index])
            self.postList?.remove(at: index)
        }
    }
    
    func showListPost(favorite: Bool) {
        if favorite {
            self.postList = self.postList?.filter { post in
                post.isFavorite
            }
            delegate?.updateUI()
        } else {
            getListFromDB()
        }
    }
    
    func deleteListAll(){
        self.postList?.removeAll()
        deleteListFromDB()
        delegate?.updateUI()
    }
    
}
