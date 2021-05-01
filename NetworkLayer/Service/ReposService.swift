//
//  ReposService.swift
//  NetworkLayer
//
//  Created by Yousef on 4/27/21.
//

import NetworkingFramework

public final class ReposService {
    
    /// Calls Github API to fetch public repos
    /// - Parameters:
    ///   - completion: Result Closure which is fired on completion of request
    class func getRepositories(completion: @escaping(Result<[Repository], NetworkingError>)-> Void) {
        
        let ep = Endpoints.repos
        
        NetworkingManager.request(ep.fullURL,
                                  ep.method,
                                  decodingType: [Repository].self,
                                  validator: 200...299,
                                  completion: completion)
        
    }

}
