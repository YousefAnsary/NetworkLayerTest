//
//  Endpoints.swift
//  NetworkLayer
//
//  Created by Yousef on 4/30/21.
//

import NetworkingFramework

enum Endpoints: String {
    
    case repos = "repositories"
    
    var method: HTTPMethod {
        switch self {
        case .repos:
            return .get
        }
    }
    
    var fullURL: String {
        "https://api.github.com/" + self.rawValue
    }
}
