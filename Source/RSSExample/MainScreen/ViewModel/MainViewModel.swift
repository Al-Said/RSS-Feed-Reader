//
//  MainViewModel.swift
//  RSSExample
//
//  Created by Said on 14.07.2022.
//

import UIKit
import RxSwift

class MainViewModel: NSObject {

    var title: String = NSLocalizedString("main", comment: "").capitalized
    
    func fetchData() -> Observable<[MainModel]> {
        return Observable.create { observer -> Disposable in
            guard let path = Bundle.main.path(forResource: "rssList", ofType: "json") else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create { }
            }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let items = try JSONDecoder().decode([MainModel].self, from: data)
                observer.onNext(items)
            } catch {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
            }
            return Disposables.create { }
        }
    }
    
    func configureCell(_ cell: MainTableViewCell, with item: MainModel) {
        cell.configureCell(with: item)
    }
    
    func getViewModel(_ item: MainModel) -> FeedDetailViewModel {
        guard let url = URL(string: item.link) else {
            return FeedDetailViewModel()
        }
        return FeedDetailViewModel(feedUrl: url, title: item.title)
    }
}
