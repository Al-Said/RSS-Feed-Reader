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
    private lazy var rssImageView = UIImageView()
    private lazy var rssTitleLabel =  initTitleLabel()
    private lazy var rssDescriptionLabel = initDescriptionLabel()
    private lazy var rightChevronImageView = initChevron()
    private lazy var labelStackView =  initLabelStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(rssImageView)
        addSubview(rightChevronImageView)
        addSubview(labelStackView)
        makeConstraints()
    }
    
    func initChevron() -> UIImageView {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "chevron.right")
        imgView.tintColor = .systemGray3
        return imgView
    }
    
    
    func initTitleLabel() -> UILabel {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }
    
    func initDescriptionLabel() -> UILabel {
        let lbl = UILabel()
        lbl.font = .italicSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }
    
    func initLabelStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [rssTitleLabel, rssDescriptionLabel])
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        return stack
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
