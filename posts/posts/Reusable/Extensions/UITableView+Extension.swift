//
//  UITableView+Extension.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import UIKit

extension UITableView {
    func register(cell: TableViewCellCatalog, identifier: CellReuseIdentifierAll) {
        register(.instantiate(withCell: cell), forCellReuseIdentifier: identifier.rawValue)
    }
}
extension UINib {
    static func instantiate(withCell cell: TableViewCellCatalog) -> UINib {
        let view = UINib(nibName: cell.rawValue, bundle: nil)
        return view
    }
}
