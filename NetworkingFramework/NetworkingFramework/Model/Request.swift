//
//  Request.swift
//  NetworkingFramework
//
//  Created by Yousef on 4/27/21.
//

import Foundation

///Structure to compse request data
public struct Request {
    
    public let url: String
    public let method: HTTPMethod
    public let headers: [String: String]?
    public let parameters: [String: Any]?
    
}
