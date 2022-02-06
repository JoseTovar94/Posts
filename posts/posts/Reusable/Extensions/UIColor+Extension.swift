//
//  UIColor+Extension.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import UIKit
import Foundation

extension UIColor {
    // MARK: - Primary
    
    @nonobjc class var postPrimary: UIColor {
        return UIColor(named: "postPrimary") ?? .init(hex: "343EFF")
    }
    
    @nonobjc class var postPrimaryAlpha5: UIColor {
        return UIColor(named: "postPrimary-alpha-5") ?? UIColor.postPrimary.withAlphaComponent(0.05)
    }
    
    @nonobjc class var postPrimaryAlpha10: UIColor {
        return UIColor(named: "postPrimary-alpha-10") ?? UIColor.postPrimary.withAlphaComponent(0.10)
    }
    
    // MARK: - Secondary
    @nonobjc class var postSecondary: UIColor {
        return UIColor(named: "postSecondary") ?? .init(hex: "ED881D")
    }
    
    // MARK: - Surface
    @nonobjc class var postSurface: UIColor {
        return UIColor(named: "postSurface") ?? .init(hex: "FAFAFA")
    }
    
    @nonobjc class var postDisable: UIColor {
        return UIColor(named: "postDisable") ?? .init(hex: "ADADAD")
    }
    
    @nonobjc class var postSecodondaryAlpha80: UIColor {
        return UIColor(named: "postSecondary-alpha-80") ?? UIColor.postPrimary.withAlphaComponent(0.10)
    }
    
    // MARK: - Convert
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format: "#%06x", rgb)
    }
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
