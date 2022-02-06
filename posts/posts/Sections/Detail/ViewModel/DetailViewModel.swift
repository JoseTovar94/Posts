//
//  DetailViewModel.swift
//  posts
//
//  Created by Jose Tovar on 5/02/22.
//

import Foundation

struct DetailViewModel {
    var cells = [Cell]()
    
    struct Cell {
        let idState: CategoryCellDetail?
        let postViewModel: PostViewModel?
        let commentsViewModel: [Comments]?
        
        init(idState: CategoryCellDetail? = nil, postViewModel: PostViewModel? = nil, commentsViewModel: [Comments]? = nil){
            self.idState = idState
            self.postViewModel = postViewModel
            self.commentsViewModel = commentsViewModel
        }
    }
}
