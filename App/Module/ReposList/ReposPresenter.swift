//
//  ReposPresenter.swift
//  NetworkLayer
//
//  Created by Yousef on 4/27/21.
//

import Foundation

protocol HomeDelegate: Delegate {
    func repositoriesDidLoad()
    func repositoriesFetchDidFailed(withError error: Error)
}

class ReposPresenter {
    
    private weak var delegate: HomeDelegate?
    private var allRepos: [Repository]
    private var repos: [Repository]?
    private var pageSize = 10
    private var searchKeyword = ""
    private(set) var page = 1
    var repositoriesCount: Int {
        min(repos?.count ?? 0, page * pageSize)
    }
    var totalPages: Int {
        let reposCount = Double(repos?.count ?? 0)
        let numOfPages = reposCount / Double(pageSize)
        return Int(ceil(numOfPages))
    }
    private var searchTask: DispatchWorkItem?
    
    init(delegate: HomeDelegate) {
        self.delegate = delegate
        self.allRepos = []
    }
    
    ///Loads repos and resets page to 1
    func fetchRepos() {
        page = 1
        ReposService.getRepositories{ res in
            switch res {
            case .success(let repos):
                self.reposDidFetched(repos)
            case .failure(let err):
                self.reposFetchFailed(withError: err)
            }
        }
    }
    
    ///Repos Fetch Success Handler
    private func reposDidFetched(_ repos: [Repository]) {
        self.allRepos = repos
        self.repos = repos
        delegateRepos()
    }
    
    ///Repos Fetch Failure Handler
    private func reposFetchFailed(withError error: Error) {
        DispatchQueue.main.async {
            self.delegate?.repositoriesFetchDidFailed(withError: error)
        }
    }
    
    ///Increments page to load more repos
    func paginate() {
        page += 1
        delegateRepos()
    }
    
    ///Calles the delegate on main thread
    private func delegateRepos() {
        DispatchQueue.main.async {
            self.delegate?.repositoriesDidLoad()
        }
    }
    
    ///Returns repository object at given index
    func repository(atIndex index: Int)-> Repository? {
        guard index < repos?.count ?? 0 else {return nil}
        return repos![index]
    }
    
    ///Configures cell at given index with appropriate data
    func setupCell(_ cell: inout RepoCell, atIndex index: IndexPath) {
        
        guard let item = repository(atIndex: index.row) else { return }
        
        cell.configureCell(imgURL: item.owner?.avatarURL ?? "", name: item.name,
                           owner: "Creator: \(item.owner?.login ?? "")")
    }
    
}
