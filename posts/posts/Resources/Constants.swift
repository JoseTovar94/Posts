//
//  Constants.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import Foundation
import UIKit

struct Constants {
    struct Request {
        
        // MARK: Base
#if DEVELOPMENT
        static var apiBaseURL = "https://jsonplaceholder.typicode.com"
#else
        static var apiBaseURL = "https://jsonplaceholder.typicode.com"
#endif
        
        // MARK: url
        static let home = "/posts"
        static let detail = "/comments"
        static let baseImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/"
    }
    
    // MARK: Text
    struct Text {
        static let titleDescriptionDetail = "Description:"
        static let titleInfoUserDetail = "User:"
        static let titleComments = "Comments"
        
    }
    
    // MARK: Size
    struct Size {
        static let textSmall: CGFloat = 13
        static let textMedium: CGFloat = 16
        static let textLarge: CGFloat = 20
        
        static let topAnchor: CGFloat = 15
        static let leftAnchor: CGFloat = 20
        static let rightAnchor: CGFloat = 20
        static let bottomAnchor: CGFloat = 20
        
    }
    
    // MARK: Fonts
    struct AppFonts {
        static let regular = "DMSans-Regular"
        static let bold = "DMSans-Bold"
        static let italic = "DMSans-Italic"
        static let medium = "DMSans-Medium"
    }
}
