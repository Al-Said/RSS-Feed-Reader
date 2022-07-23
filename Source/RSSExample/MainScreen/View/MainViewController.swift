//
//  MainViewController.swift
//  RSSExample
//
//  Created by Said on 14.07.2022.
//

import UIKit
import RxSwift

class MainViewController: RSSBaseViewController {

    private let viewModel: IMainViewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    private lazy var rssTable = initTable()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTable()
        bind()
    }

    func setupUI() {
        self.navigationItem.title = viewModel.title
    }
    
    func initTable() -> UITableView {
        let table = UITableView()
        table.delegate = self
        table.register(MainTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return table
    }
    
    func addTable() {
        view.addSubview(rssTable)
        rssTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind() {
        viewModel.fetchData().bind(to: rssTable.rx.items(cellIdentifier: cellIdentifier)) { [weak self]
            row, item, cell in
            if let cell = cell as? MainTableViewCell {
                self?.viewModel.configureCell(cell, with: item)
            }
        }.disposed(by: disposeBag)

        rssTable.rx.modelSelected(MainModel.self).bind { [weak self] mainModel in
            let vm = self?.viewModel.getViewModel(mainModel) ?? FeedDetailViewModel()
            self?.coordinator?.openFeedDetail(vm)
        }
        .disposed(by: disposeBag)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        baseRowHeight
    }
}
