//
//  TableViewCell.swift
//  RSSExample
//
//  Created by Said on 14.07.2022.
//

import UIKit
import SnapKit
import FeedKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {
    
    private var feedTitle: UILabel!
    private var feedDescription: UILabel!
    private var feedImageView: UIImageView!
    private var feedStack: UIStackView!
    
    var model: RSSFeedItem! = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        feedTitle = UILabel()
        feedDescription = UILabel()
        feedImageView = UIImageView()
        feedStack = UIStackView(arrangedSubviews: [feedTitle, feedDescription, feedImageView])
        feedStack.axis = .vertical
        feedStack.alignment = .fill
        feedStack.spacing = 8
        addSubview(feedStack)
        

        feedStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        self.feedImageView.isHidden = true
        
        feedTitle.font = UIFont.boldSystemFont(ofSize: 15)
        feedDescription.font = UIFont.italicSystemFont(ofSize: 12)
        
        feedTitle.numberOfLines = 0
        feedDescription.numberOfLines = 0
        
        feedDescription.adjustsFontSizeToFitWidth = true
        feedDescription.textAlignment = .justified
    }
    
    
    func configureCell(_ item: RSSFeedItem, imageURL: URL?) {
        self.model = item
        let t = item.title ?? "No title"
        let d = item.description ?? "No description"
        self.feedTitle.text = t.removeHTMLTag().trimingLeadingSpaces()
        self.feedDescription.text = d.removeHTMLTag().trimingLeadingSpaces()
        
        if let imageURL = imageURL {
            self.feedImageView.kf.setImage(with: imageURL)
            self.feedImageView.snp.makeConstraints { make in
                make.height.equalTo(150.0)
                self.feedImageView.isHidden = false
                self.layoutIfNeeded()
                self.layoutSubviews()
            }
        }
    }

}
