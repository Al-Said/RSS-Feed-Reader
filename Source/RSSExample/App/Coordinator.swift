//
//  Coordinator.swift
//  RSSExample
//
//  Created by Said on 23.07.2022.
//

import Foundation
import UIKit

protocol ICoordinator {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}

class MainCoordinator: ICoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let firstVC = MainViewController()
        firstVC.coordinator = self
        firstVC.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(firstVC, animated: true)
    }
    
    func openFeedDetail(_ viewModel: IFeedDetailViewModel) {
       let vc = FeedDetailViewController(viewModel: viewModel)
       self.navigationController.pushViewController(vc, animated: true)
    }
    
}
