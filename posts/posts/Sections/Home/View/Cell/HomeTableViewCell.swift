//
//  HomeTableViewCell.swift
//  posts
//
//  Created by Jose Tovar on 4/02/22.
//

import UIKit
import Material

class HomeTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var unreadImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.depth = Depth(offset: .zero, opacity: 0.1, radius: 10)
        viewContainer.layer.cornerRadius = 15.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Setup
    func setup(viewModel: PostViewModel?) {
        titleLabel.text = viewModel?.title
        unreadImage.image = UIImage(named: "Unread")
        unreadImage.isHidden = viewModel?.isRead ?? false
        
        if (viewModel?.isFavorite ?? false) {
            unreadImage.isHidden = false
            unreadImage.image = UIImage(named: "star_on")
        }
    }
}
