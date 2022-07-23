//
//  RSSBaseViewController.swift
//  RSSExample
//
//  Created by Said on 23.07.2022.
//

//All Base view controllers should extend this class
import UIKit

class RSSBaseViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    
    var baseRowHeight: CGFloat = 120.0
    var cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
