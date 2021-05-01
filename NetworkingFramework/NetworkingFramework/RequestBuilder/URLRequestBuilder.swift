//
//  URLRequestBuilder.swift
//  NetworkingFramework
//
//  Created by Yousef on 4/27/21.
//

import Foundation

protocol RequestParametersEncoder: URLRequestBuilder {
//    func urlRequest(fromURL url: URL, params: [String: Any]?) throws -> URLRequest
    func urlRequest(fromString urlString: String, params: [String: Any]?) throws -> URLRequest
}

/// Builds and encodes paramters for URLRequests
protocol URLRequestBuilder {}

extension URLRequestBuilder {
    
    func setHeaders(_ headers: [String: String]?, forRequest request: inout URLRequest) {
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
    }
    
    func setMethod(_ method: HTTPMethod, forRequest request: inout URLRequest) {
        request.httpMethod = method.rawValue
    }
    
}
