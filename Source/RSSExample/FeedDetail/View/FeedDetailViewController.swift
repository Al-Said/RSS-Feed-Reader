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
    
    var feedTable: UITableView!
    let refreshControl = UIRefreshControl()
    var viewModel: FeedDetailViewModel! = FeedDetailViewModel()
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
        addTable()
    }
    
    func addTable() {
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        feedTable = UITableView(frame: self.view.bounds)
        feedTable.register(FeedTableViewCell.self, forCellReuseIdentifier: "Cell")

        view.addSubview(feedTable)
        feedTable.addSubview(refreshControl)
        feedTable.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }

        viewModel.fetchData().bind(to: feedTable.rx.items(cellIdentifier: "Cell")) {
            row, item, cell in
            (cell as! FeedTableViewCell).configureCell(item, imageURL: URL(string: (item.description ?? "").getImageUrlStr()))
        }.disposed(by: disposeBag)

        feedTable.rx.modelSelected(RSSFeedItem.self).bind { [weak self] rssFeedItem in
            self?.viewModel.itemSelected(rssFeedItem)
        }
        .disposed(by: disposeBag)
    }
    
    @objc func refreshTable() {
        viewModel.refreshTable()
        refreshControl.endRefreshing()

        if refreshControl.isRefreshing { refreshControl.endRefreshing() }
    }
}

