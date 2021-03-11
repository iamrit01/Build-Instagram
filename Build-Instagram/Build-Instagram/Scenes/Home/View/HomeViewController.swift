//
//  HomeViewController.swift
//  Build-Instagram
//
//  Created by Mizia Lima on 3/10/21.
//

import UIKit

protocol HomeViewEvents: AnyObject {
    func push(viewController: UIViewController)
    func present(viewController: UIViewController)
}

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func checkAuthStatusFromUser(){
        
    }
}

extension HomeViewController: HomeViewEvents {
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
