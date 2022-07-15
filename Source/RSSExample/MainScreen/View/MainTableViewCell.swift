//
//  MainTableViewCell.swift
//  RSSExample
//
//  Created by Said on 14.07.2022.
//

import UIKit
import Kingfisher
import SnapKit

class MainTableViewCell: UITableViewCell {

    var model: MainModel!
    private var rssImageView: UIImageView!
    private var rssTitleLabel: UILabel!
    private var rssDescriptionLabel: UILabel!
    private var rightChevronImageView: UIImageView!
    private var labelStackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addImages()
        addLabels()
        makeConstraints()
    }
    
    func addImages() {
        rssImageView = UIImageView()
        rightChevronImageView = UIImageView()
        rightChevronImageView.image = UIImage(systemName: "chevron.right")
        rightChevronImageView.tintColor = .systemGray3
        
        addSubview(rssImageView)
        addSubview(rightChevronImageView)
    }
    
    func addLabels() {
        rssTitleLabel = UILabel()
        rssDescriptionLabel = UILabel()
        rssTitleLabel.font = .boldSystemFont(ofSize: 18)
        rssDescriptionLabel.font = .italicSystemFont(ofSize: 15)
        rssDescriptionLabel.numberOfLines = 0
        
        labelStackView = UIStackView(arrangedSubviews: [rssTitleLabel, rssDescriptionLabel])
        labelStackView.distribution = .fill
        labelStackView.axis = .vertical
        labelStackView.alignment = .center
        
        addSubview(labelStackView)
    }
    
    func makeConstraints() {
        rssImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(75)
            make.leading.equalToSuperview().offset(16)
        }
        
        rightChevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.trailing.equalToSuperview().inset(16)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(rssImageView.snp.trailing).offset(16)
            make.trailing.equalTo(rightChevronImageView.snp.leading).inset(16)
        }
    }
    
    func configureCell(with model: MainModel) {
        self.model = model
        self.rssTitleLabel.text = model.title
        self.rssDescriptionLabel.text = model.description
        let url = URL(string: model.image)
        self.rssImageView.kf.setImage(with: url)
    }

}
