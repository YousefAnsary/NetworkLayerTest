//
//  ResponseValidator.swift
//  NetworkingFramework
//
//  Created by Yousef on 5/1/21.
//

import Foundation

internal final class ResponseValidator {
    
    
    /// Validates given data based on specific criteria
    /// - Parameters:
    ///   - data: data object to check if it is nil
    ///   - urlResponse: for status code check based on passed range
    ///   - error: to check previous produced error and map it to NetworkingError
    ///   - validator: specific range of status codes that will be treated as success
    /// - Returns: Result type with the NetworkingError causing failed validation, Data object otherwise
    internal static func validate(
            data: Data?,
            urlResponse: URLResponse?,
            error: Error?,
            validator: ClosedRange<Int>)
            -> Result<Data, NetworkingError> {
        
        guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else {
            return .failure(.unknown(statusCode: 0, data: data, error: error))
        }
        
        guard validator ~= statusCode else {
            return .failure(NetworkingError(rawValue: statusCode, data: data, error: error))
        }
        
        guard error == nil else {
            if error is InvalidURL {
                return .failure(.invalidURL(url: (error as! InvalidURL).url))
            } else if error is InvalidBodyParameters {
                return .failure(.invalidParameters(parameters: (error as! InvalidBodyParameters).parameters))
            }
            return .failure(.unknown(statusCode: 0, data: data, error: error))
        }
        
        guard let safeData = data else {
            return .failure(.unknown(statusCode: 0, data: data, error: error))
        }
        
        return .success(safeData)
        
    }
    
}
