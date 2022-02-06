//
//  CatalogView.swift
//  posts
//
//  Created by Jose Tovar on 5/02/22.
//

import Foundation
import UIKit

enum StoryboardCatalog: String {
    case Splash
    case Home
    case Detail
    
    func createInstance() -> UIStoryboard {
        return UIStoryboard(name: String(describing: self), bundle: nil)
    }
}

enum ViewControllerCatalog: RawRepresentable {
    case Splash
    case Home
    case HomeNavigation
    case Detail
    
    
    var rawValue: (class: AnyClass, storyboard: StoryboardCatalog) {
        switch self {
        case .Splash:                  return (SplashViewController.self, .Splash)
        case .Home:                    return (HomeViewController.self, .Home)
        case .HomeNavigation:          return (HomeNavigationController.self, .Home)
        case .Detail:                  return (DetailViewController.self, .Detail)
        }
    }
    
}

extension ViewControllerCatalog: CaseIterable {
    init?(rawValue: (class: AnyClass, storyboard: StoryboardCatalog)) {
        return nil
    }
    
    init?(name: String) {
        for item in ViewControllerCatalog.allCases where String(describing: item) == name {
            self = item
            return
        }
        return nil
    }
    
    var className: String {
        return String(describing: self.rawValue.class)
    }
    
    var name: String {
        return String(describing: self)
    }
    
    func createInstance() -> UIViewController? {
        let sb = self.rawValue.storyboard.createInstance()
        let vc = sb.instantiateViewController(withIdentifier: String(describing: self.rawValue.class))
        return vc
    }
}
