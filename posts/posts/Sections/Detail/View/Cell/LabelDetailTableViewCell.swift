//
//  LabelDetailTableViewCell.swift
//  posts
//
//  Created by Jose Tovar on 5/02/22.
//

import UIKit

class LabelDetailTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var contenView: UIView!
    
    // MARK: - init
    var detailViewModel: PostViewModel? {
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
    
    // MARK: - Properties
    private var titleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(size: Constants.Size.textLarge)
        label.text = Constants.Text.titleDescriptionDetail
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(size: Constants.Size.textMedium)
        return label
    }()
    
    private var titleUserLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(size: Constants.Size.textLarge)
        label.text = Constants.Text.titleInfoUserDetail
        return label
    }()
    
    private var infoUserLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(size: Constants.Size.textMedium)
        return label
    }()
    
    
    // MARK: Setup
    func updateView() {
        descriptionLabel.text = detailViewModel?.body
        infoUserLabel.text = String(detailViewModel?.id ?? 0)
        
        contenView.addSubview(titleDescriptionLabel)
        NSLayoutConstraint.activate([
            titleDescriptionLabel.topAnchor.constraint(equalTo: contenView.topAnchor, constant: Constants.Size.topAnchor),
            titleDescriptionLabel.leftAnchor.constraint(equalTo: contenView.leftAnchor, constant: Constants.Size.leftAnchor),
            titleDescriptionLabel.rightAnchor.constraint(equalTo: contenView.rightAnchor, constant: -(Constants.Size.rightAnchor))
        ])
        
        contenView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleDescriptionLabel.bottomAnchor, constant: Constants.Size.topAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: titleDescriptionLabel.leftAnchor, constant: 30),
            descriptionLabel.rightAnchor.constraint(equalTo: titleDescriptionLabel.rightAnchor)
        ])
        
        contenView.addSubview(titleUserLabel)
        NSLayoutConstraint.activate([
            titleUserLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.Size.topAnchor + 10),
            titleUserLabel.leftAnchor.constraint(equalTo: titleDescriptionLabel.leftAnchor),
            titleUserLabel.rightAnchor.constraint(equalTo: titleDescriptionLabel.rightAnchor)
        ])
        
        contenView.addSubview(infoUserLabel)
        NSLayoutConstraint.activate([
            infoUserLabel.topAnchor.constraint(equalTo: titleUserLabel.bottomAnchor, constant: Constants.Size.topAnchor),
            infoUserLabel.leftAnchor.constraint(equalTo: titleDescriptionLabel.leftAnchor, constant: 30),
            infoUserLabel.rightAnchor.constraint(equalTo: titleDescriptionLabel.rightAnchor),
            infoUserLabel.bottomAnchor.constraint(equalTo: contenView.bottomAnchor, constant: -(Constants.Size.bottomAnchor))
        ])
    }
}
