//
//  SplashViewController.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var progressView: CircularView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.startIndeterminate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.goToHomeView()
        }
    }
    
    // MARK: - Actions
    func goToHomeView() {
        guard let loginVC = ViewControllerCatalog.HomeNavigation.createInstance() else { return }
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}
