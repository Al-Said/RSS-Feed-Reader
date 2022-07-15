//
//  MainViewController.swift
//  RSSExample
//
//  Created by Said on 14.07.2022.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {

    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    private var optionsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTable()
    }

    func setupUI() {
        self.navigationItem.title = viewModel.title
    }
    
    func addTable() {
        optionsTableView = UITableView()
        optionsTableView.delegate = self
        optionsTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "Cell")

        view.addSubview(optionsTableView)
        optionsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        viewModel.fetchData().bind(to: optionsTableView.rx.items(cellIdentifier: "Cell")) {
            row, item, cell in
            (cell as! MainTableViewCell).configureCell(with: item)
        }.disposed(by: disposeBag)

        optionsTableView.rx.modelSelected(MainModel.self).bind { [weak self] mainModel in
            self?.navigationController?.pushViewController(FeedDetailViewController(viewModel: self?.viewModel.getViewModel(mainModel) ?? FeedDetailViewModel()), animated: true)
        }
        .disposed(by: disposeBag)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0
    }
}
