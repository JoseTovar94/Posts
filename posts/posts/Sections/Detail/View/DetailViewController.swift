//
//  DetailViewController.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    var post: PostViewModel?
    var viewModel = DetailViewModelController()
    
    private let favoriteBtn: UIButton = {
        let favoriteBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        favoriteBtn.setButtonNormal(image: UIImage(named: "star_off"), color: .postSurface)
        favoriteBtn.setButtonSelect(image: UIImage(named: "star_on"), color: .postSurface)
        return favoriteBtn
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.post = post
        tableView.separatorStyle = .none
        loadUI()
        loadResults()
    }
    
    func loadUI() {
        addButtonItem()
        setupTableView()
    }
    
    func loadResults() {
        UIApplication.showHUD()
        viewModel.loadResults(success: {
            self.tableView.reloadData()
            self.favoriteBtn.isSelected = self.post?.isFavorite ?? false
            UIApplication.dismissHUD()
        }, errorMessage: { (error) in
            UIApplication.dismissHUD()
        })
    }
    
    //MARK: Bar Items
    private func addButtonItem() {
        let buttonItem = UIBarButtonItem()
        buttonItem.customView = favoriteBtn
        favoriteBtn.addTarget(self, action: #selector(didTapFavorite), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    @objc func didTapFavorite() {
        favoriteBtn.isSelected = !favoriteBtn.isSelected
        if let listPost = post {
            viewModel.addToFavorite(post: listPost, isFavorite: favoriteBtn.isSelected)
        }
    }
    
}
// MARK: - Table DataSource & Delegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        tableView.register(cell: .LabelDetailTableViewCell, identifier: .LabelDetailTableViewCell)
        tableView.register(cell: .CommentsTableViewCell, identifier: .CommentsTableViewCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = getCellIdentifier(state: viewModel.viewModel.cells[indexPath.row].idState)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        
        let cellData = viewModel.viewModel.cells[indexPath.row]
        if let resultCell = cell as? LabelDetailTableViewCell {
            resultCell.detailViewModel = cellData.postViewModel
            
        } else if let resultCell = cell as? CommentsTableViewCell {
            resultCell.commentsViewModel = cellData.commentsViewModel
        }
        
        return cell
    }
    
    func getCellIdentifier(state: CategoryCellDetail?) -> String {
        var cellIdentifier = CellReuseIdentifierAll.LabelDetailTableViewCell
        switch CategoryCellDetail(rawValue: state?.rawValue ?? "") {
        case .infoUser:
            cellIdentifier = .LabelDetailTableViewCell
        case .comments:
            cellIdentifier = .CommentsTableViewCell
        default: break
        }
        return cellIdentifier.rawValue
    }
    
}
