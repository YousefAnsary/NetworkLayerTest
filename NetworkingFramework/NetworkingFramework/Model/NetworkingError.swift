//
//  NetworkingError.swift
//  NetworkingFramework
//
//  Created by Yousef on 4/27/21.
//

import Foundation

///Errors arises from networking operations
public enum NetworkingError: Error {
    case unAuthenticated(data: Data?)
    case unAuthorized(data: Data?)
    case notFound(data: Data?)
    case methodNotAllowed(data: Data?)
    case internalServerError(data: Data?)
    case unknown(statusCode: Int, data: Data?, error: Error?)
    case decodingFailed(data: Data?, error: Error?)
    case invalidURL(url: String)
    case invalidParameters(parameters: [String: Any])
    
    internal init(rawValue: Int, data: Data?, error: Error?) {
        switch rawValue {
        case 401:
            self = .unAuthenticated(data: data)
        case 403:
            self = .unAuthorized(data: data)
        case 404:
            self = .notFound(data: data)
        case 405:
            self = .methodNotAllowed(data: data)
        case 500:
            self = .internalServerError(data: data)
        default:
            self = .unknown(statusCode: rawValue, data: data, error: error)
        }
    }
    
}

/// Thrown on failed URL creations
public struct InvalidURL: LocalizedError {
    
    let url: String
    
    public var errorDescription: String? {
        "Invalid URL \(url)"
    }
    
    public var failureReason: String? {
        "Coudln't Create URL Object from given string \(url)"
    }
    
}

/// Thrown on failed encoding of dictionary to Data
public struct InvalidBodyParameters: LocalizedError {
    
    let parameters: [String: Any]
    let error: Error
    
    public var errorDescription: String? {
        "Invalid Paramters \(parameters)"
    }
    
    public var failureReason: String? {
        "Coudln't encode Data object from given dictionary \(parameters) with error: \(error)"
    }
    
}
 
/// Thrown on URLSessionDataTask nil Data response
public struct InvalidData: LocalizedError {
    let data: Data?
    
    public var errorDescription: String? {
        "invalid or nil data"
    }
    
}
