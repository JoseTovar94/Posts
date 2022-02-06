//
//  CommentsTableViewCell.swift
//  posts
//
//  Created by Jose Tovar on 5/02/22.
//

import UIKit
import Material

class CommentsTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - init
    var commentsViewModel: [Comments]? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup
    func updateView() {
        let viewTitle = UIView()
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.backgroundColor = .postDisable
        viewTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let labelTitle = UILabel()
        labelTitle.setupLabel(size: Constants.Size.textLarge, color: .postSecondary)
        labelTitle.text = Constants.Text.titleComments
        viewTitle.addSubview(labelTitle)
        stackView.addArrangedSubview(viewTitle)
        
        
        if let commentsList = commentsViewModel {
            for data in commentsList {
                
                if stackView.arrangedSubviews.count > 0 {
                    let separator = UIView()
                    separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
                    separator.backgroundColor = .black
                    stackView.addArrangedSubview(separator)
                }
                
                let labelComments = UILabel()
                labelComments.setupLabel(size: Constants.Size.textSmall, color: .postSecodondaryAlpha80)
                labelComments.text = data.body
                self.stackView.addArrangedSubview(labelComments)
            }
        }
    }
}
