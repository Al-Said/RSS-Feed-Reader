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

class FeedDetailViewController: RSSBaseViewController {
    
    private lazy var feedTable = addTable()
    private lazy var refreshControl = UIRefreshControl()
    let viewModel: IFeedDetailViewModel!
    let disposeBag = DisposeBag()
    lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    init(viewModel: IFeedDetailViewModel) {
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
        table.register(FeedTableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        view.addSubview(table)
        table.addSubview(refreshControl)
        table.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        return table
    }
    
    func bind() {
        startActivityIndicator()
        viewModel.fetchData().bind(to: feedTable.rx.items(cellIdentifier: cellIdentifier)) {
            [weak self] row, item, cell in
            self?.removeActivityIndicator()
            if let cell = cell as? FeedTableViewCell {
                self?.viewModel.configureCell(cell, with: item)
            }
        }.disposed(by: disposeBag)

        feedTable.rx.modelSelected(RSSFeedItem.self).bind { [weak self] rssFeedItem in
            self?.viewModel.itemSelected(rssFeedItem)
        }
        .disposed(by: disposeBag)
    }
    
    func startActivityIndicator() {
        feedTable.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    @objc func reloadItems() {
        viewModel.reloadItems()
        refreshControl.endRefreshing()
        if refreshControl.isRefreshing { refreshControl.endRefreshing() }
    }
    
}

