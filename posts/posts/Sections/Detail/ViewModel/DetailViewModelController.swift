//
//  DetailViewModelController.swift
//  posts
//
//  Created by Jose Tovar on 5/02/22.
//

import Foundation
class DetailViewModelController {
    
    // MARK: - Vars
    var post: PostViewModel?
    var viewModel = DetailViewModel()
    
    // MARK: - init
    func loadResults(success: @escaping () -> Void, errorMessage: @escaping (String) -> Void) {
        let apiRoute = APIRoute<APIRequestParams.Detail>.Detail()
        apiRoute.params = .init(id: post?.id ?? 0)
        APINetworking.request(route: apiRoute) { (response: [Comments]) in
            self.viewModel.cells = []
            self.viewModel.cells.append(.init(idState: .infoUser, postViewModel: self.post, commentsViewModel: nil))
            self.viewModel.cells.append(.init(idState: .comments, postViewModel: nil, commentsViewModel: response))
            success()
        }onError: { (error) in
            print("Error")
        }
    }
    
    // MARK: - Actions
    func addToFavorite(post: PostViewModel, isFavorite: Bool) {
        RealmHelper.sharedInstance.postUpdate(postViewModel: post, isFavorite: isFavorite, updateFavorite: true)
    }
}
