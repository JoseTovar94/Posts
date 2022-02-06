//
//  UIButton+Extension.swift
//  posts
//
//  Created by Jose Tovar on 5/02/22.
//
import UIKit

extension UIButton {
    
    func setButtonNormal(image: UIImage?, color: UIColor?) {
        self.setImage(image?.withTintColor(color ?? .white, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    func setButtonSelect(image: UIImage?, color: UIColor?) {
        self.setImage(image?.withTintColor(color ?? .white, renderingMode: .alwaysOriginal), for: .selected)
    }
}
