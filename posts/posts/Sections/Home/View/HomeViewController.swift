//
//  HomeViewController.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var postSegmented: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    private let refreshBtn: UIButton = {
        let refreshBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        refreshBtn.setButtonNormal(image: UIImage(named: "icon_refresh"), color: .postSurface)
        return refreshBtn
    }()
    
    var viewModel = HomeViewModelController()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        loadUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        postSegmented.selectedSegmentIndex = 0
    }
    
    private func loadUI() {
        addButtonItem()
        setupSegmentedControl()
        setupTableView()
    }
    
    private func loadData() {
        UIApplication.showHUD()
        viewModel.loadData(success: {
            self.tableView.reloadData()
            UIApplication.dismissHUD()
        }, errorMessage: { (error) in
            UIApplication.dismissHUD()
        })
    }
    
    //MARK: Bar Items
    private func addButtonItem() {
        let buttonItem = UIBarButtonItem()
        buttonItem.customView = refreshBtn
        refreshBtn.addTarget(self, action: #selector(didTapRefresh), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    @objc func didTapRefresh() {
        viewModel.deleteListFromDB()
        loadData()
    }
    
    //MARK: SegmentedControl
    private func setupSegmentedControl() {
        postSegmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        postSegmented.setTitleTextAttributes([.foregroundColor: UIColor.postPrimary], for: .normal)
    }
    
    //MARK: Actions
    @IBAction func tapSegmentAction(_ sender: UISegmentedControl) {
        let isFavorite = sender.selectedSegmentIndex == 0 ? false: true
        viewModel.showListPost(favorite: isFavorite)
    }
    
    @IBAction func tapDeleteAll(_ sender: UIButton) {
        viewModel.deleteListAll()
    }
    
}
// MARK: - Table DataSource & Delegate
extension HomeViewController: UITableViewDataSource {
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cell: .HomeTableViewCell, identifier: .HomeTableViewCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.stringRepresentation, for: indexPath) as? HomeTableViewCell {
            cell.selectionStyle = .none
            cell.setup(viewModel: viewModel.postList?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel.postList else { return }
        self.viewModel.postRead(post: viewModel[indexPath.row])
        
        guard let vc = ViewControllerCatalog.Detail.createInstance() as? DetailViewController else { return }
        vc.post = viewModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.viewModel.deletePost(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: - Protocol
extension HomeViewController: AsyncResponse {
    func updateUI() {
        tableView.reloadData()
    }
}
