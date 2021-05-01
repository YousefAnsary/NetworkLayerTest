//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Yousef on 4/27/21.
//

import UIKit

class ReposVC: BaseViewController {

    @IBOutlet private weak var repositoriesTV: UITableView!
    var presenter: ReposPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        startLoading()
        presenter?.fetchRepos()
    }
    
    private func setupTableView() {
        repositoriesTV.register(RepoCell.self)
        repositoriesTV.delegate = self
        repositoriesTV.dataSource = self
    }

}

extension ReposVC: HomeDelegate {
    
    func repositoriesDidLoad() {
        dismissLoader()
        repositoriesTV.reloadData()
    }
    
    func repositoriesFetchDidFailed(withError error: Error) {
        dismissLoader()
        self.handleError(error: error)
    }
    
}

extension ReposVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.repositoriesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: RepoCell = tableView.dequeue()
        presenter?.setupCell(&cell, atIndex: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        145
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (presenter!.repositoriesCount - 1) && presenter!.page < presenter!.totalPages {
            startLoading()
            presenter?.paginate()
        }
    }
    
}
