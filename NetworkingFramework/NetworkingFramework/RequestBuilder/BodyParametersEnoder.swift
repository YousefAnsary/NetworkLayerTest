//
//  BodyTypeBuilder.swift
//  NetworkingFramework
//
//  Created by Yousef on 4/27/21.
//

import Foundation

/// Builds& Encodes body query parameters request i.e. POST, ...
internal final class BodyParametersEnoder: RequestParametersEncoder {
    
    func urlRequest(fromString urlString: String, params: [String : Any]?) throws -> URLRequest {
        guard let url = URL(string: urlString) else { throw InvalidURL(url: urlString) }
        var request = URLRequest(url: url)
        guard let params = params else { return request }
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            return request
        } catch {
            throw InvalidBodyParameters(parameters: params, error: error)
        }
    }
    
}
