//
//  HomeCoordinator.swift
//  GithubClient
//
//  Created by Yousef on 4/9/21.
//

import UIKit

class ReposCoordinator {
    
    private let navigationController: UINavigationController
    private var presenter: ReposPresenter?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ReposVC(nibName: "ReposView", bundle: nil)
        self.presenter = ReposPresenter(delegate: vc)
        vc.presenter = presenter
        navigationController.pushViewController(vc, animated: true)
    }
    
}
