//
//  ViewController.swift
//  RSSExample
//
//  Created by Said on 14.07.2022.
//

import UIKit
import SnapKit
import FeedKit
import RxSwift
import RxCocoa

class FeedDetailViewController: UIViewController {
    
    private lazy var feedTable = addTable()
    private lazy var refreshControl = UIRefreshControl()
    let viewModel: FeedDetailViewModel!
    let disposeBag = DisposeBag()
    
    init(viewModel: FeedDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = viewModel.title
        bind()
    }
    
    func addTable() -> UITableView {
        var table = UITableView()
        refreshControl.addTarget(self, action: #selector(reloadItems), for: .valueChanged)
        table = UITableView(frame: self.view.bounds)
        table.register(FeedTableViewCell.self, forCellReuseIdentifier: "Cell")

        view.addSubview(table)
        table.addSubview(refreshControl)
        table.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        return table
    }
    
    func bind() {
        viewModel.fetchData().bind(to: feedTable.rx.items(cellIdentifier: "Cell")) {
            [weak self] row, item, cell in
            if let cell = cell as? FeedTableViewCell {
                self?.viewModel.configureCell(cell, with: item)
            }
        }.disposed(by: disposeBag)

        feedTable.rx.modelSelected(RSSFeedItem.self).bind { [weak self] rssFeedItem in
            self?.viewModel.itemSelected(rssFeedItem)
        }
        .disposed(by: disposeBag)
    }
    
    @objc func reloadItems() {
        viewModel.reloadItems()
        refreshControl.endRefreshing()
        if refreshControl.isRefreshing { refreshControl.endRefreshing() }
    }
}

