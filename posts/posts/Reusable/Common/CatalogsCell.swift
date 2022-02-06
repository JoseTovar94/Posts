//
//  Catalogs.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import Foundation
import UIKit

enum CategoryCellDetail: String {
    case infoUser = "info"
    case comments = "comments"
}

enum TableViewCellCatalog: String {
    case HomeTableViewCell
    case LabelDetailTableViewCell
    case CommentsTableViewCell
}

enum CellReuseIdentifierAll: String {
    case HomeTableViewCell
    case LabelDetailTableViewCell
    case CommentsTableViewCell
}

