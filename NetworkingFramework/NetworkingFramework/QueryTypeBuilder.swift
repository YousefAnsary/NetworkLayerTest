//
//  QueryTypeBuilder.swift
//  NetworkingFramework
//
//  Created by Yousef on 4/27/21.
//

import Foundation

/// Builds& Encodes url query parameters request i.e. GET, DELETE
internal final class QueryParametersEncoder: RequestParametersEncoder {
    
    func urlRequest(fromString urlString: String, params: [String : Any]?) throws -> URLRequest {
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.query = params?.map { key, val in "\(key)=\(val)" }.joined(separator: "&")
        guard let url = urlComponents?.url else { throw InvalidURL(url: urlString) }
        return URLRequest(url: url)
    }
    
}
