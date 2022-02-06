//
//  HomeNavigationController.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import UIKit

class HomeNavigationController: UINavigationController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBar()
    }
    
    // MARK: - Init
    fileprivate func customizeNavigationBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.postSurface]
            navBarAppearance.backgroundColor = .postPrimary
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
            
        } else {
            navigationController?.navigationBar.barTintColor = .postPrimary
            navigationController?.navigationBar.tintColor = .postSecondary
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
}
