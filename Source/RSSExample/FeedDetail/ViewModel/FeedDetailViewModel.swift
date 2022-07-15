//
//  FeedViewModel.swift
//  RSSExample
//
//  Created by Said on 14.07.2022.
//

import UIKit
import FeedKit
import RxSwift

class FeedDetailViewModel: NSObject {
   
    private var parser: FeedParser!
    private var rssFeed: RSSFeed?
    var items: Observable<[RSSFeedItem]>!
    var title: String = ""
    
    override init() {
        super.init()
    }
    
    init(feedUrl: URL, title: String) {
        super.init()
        //check cache if it's empty get data
        self.title = title
        parser = FeedParser(URL: feedUrl)
    }
    
    func fetchData() -> Observable<[RSSFeedItem]> {
        return Observable<[RSSFeedItem]>.create { observer -> Disposable in
            
            self.parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let feed):
                    self.rssFeed = feed.rssFeed
                    observer.onNext(feed.rssFeed?.items ?? [])                    
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create {

            }
        }
    }
    
    func refreshTable() {
        self.items = fetchData()
    }
    
    func itemSelected(_ item: RSSFeedItem) {
        guard let url = URL(string: item.link ?? "") else { return }
        UIApplication.shared.open(url)
    }
   
}

