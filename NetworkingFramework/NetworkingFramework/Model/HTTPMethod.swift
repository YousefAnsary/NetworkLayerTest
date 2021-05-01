//
//  HTTPMethod.swift
//  NetworkingFramework
//
//  Created by Yousef on 4/27/21.
//

import Foundation

/// HTTP Methods used in requests
public enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
    case delete = "DELETE"
    
    /// Indiates whether the method should encode parameters in body or not
    var isBodyParametersType: Bool {
        switch self {
        case .get:
            return false
        case .post:
            return true
        case .put:
            return true
        case .update:
            return true
        case .delete:
            return false
        }
    }
    
}
