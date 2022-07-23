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
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
    }
    
    func showErrorIfNotReachable() {
        switch Network.reachability.status {
        case .unreachable:
            showErrorPopup("There is no internet connection")
        default:
            break
        }
        print("---------------------")
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
        print("---------------------")

    }
    
    @objc func statusManager(_ notification: Notification) {
        showErrorIfNotReachable()
    }
    
    func showErrorPopup(_ description: String) {
        let title = "Error"
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true)
    }
}
