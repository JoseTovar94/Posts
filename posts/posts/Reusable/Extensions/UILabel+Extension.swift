//
//  UILabel+Extension.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import UIKit
extension UILabel {
    func setupLabel(size: CGFloat, color: UIColor = .postSecondary) {
        self.font = UIFont.boldSystemFont(ofSize: size)
        self.textAlignment = .left
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.textColor = color
    }
}

extension NSObject {
    class var stringRepresentation: String {
        let name = String(describing: self)
        return name
    }
}
