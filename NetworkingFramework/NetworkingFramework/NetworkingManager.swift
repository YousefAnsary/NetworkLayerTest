//
//  NetworkingManager.swift
//  NetworkingFramework
//
//  Created by Yousef on 4/27/21.
//

import Foundation

public final class NetworkingManager {
    
    private static let session = URLSession(configuration: .default)
    
    private init() {}
    
    /// Starts a URLSessionsData task with given data
    /// - Parameters:
    ///   - stringURL: url to request from
    ///   - method: HTTP Method i.e. GET, POST, ...
    ///   - headers: Headers of the request as Dictionary
    ///   - parameters: Parameters dictionary will be encoded in url in GET, DELETE requests, in body otherwise
    ///   - completion: Completion block to be fired on response received
    public static func request(
            _ stringURL: String,
            _ method: HTTPMethod,
            headers: [String: String]? = nil,
            parameters: [String: Any]? = nil,
            completion: @escaping (Data?, URLResponse?, Error?)-> Void) {
        
        let builder: RequestParametersEncoder = method.isBodyParametersType ? BodyParametersEnoder() : QueryParametersEncoder()
        
        var request: URLRequest!
        
        do {
            request = try builder.urlRequest(fromString: stringURL, params: parameters)
        } catch {
            completion(nil, nil, error)
            return
        }
        
        builder.setHeaders(headers, forRequest: &request)
        builder.setMethod(method, forRequest: &request)
        
        session.dataTask(with: request) { data, res, err in
            completion(data, res, err)
        }.resume()
        
    }
    
    /// Starts a URLSessionsData task with given data and deocdes result to dictionary
    /// - Parameters:
    ///   - stringURL: url to request from
    ///   - method: HTTP Method i.e. GET, POST, ...
    ///   - headers: Headers of the request as Dictionary
    ///   - parameters: Parameters dictionary will be encoded in url in GET, DELETE requests, in body otherwise
    ///   - validator: Range of status codes will pass as success, failure otherwise
    ///   - completion: Completion block with Result Type parameter to be fired on response received
    public static func request(
            _ stringURL: String,
            _ method: HTTPMethod,
            headers: [String: String]? = nil,
            parameters: [String: Any]? = nil,
            validator: ClosedRange<Int> = 200...299,
            completion: @escaping (Result<[String: Any?], NetworkingError>)-> Void) {
        
        self.request(stringURL, method, headers: headers, parameters: parameters) { data, res, err in
            
            let validatedRes = ResponseValidator.validate(data: data, urlResponse: res, error: err, validator: validator)
            
            completion(validatedRes.flatMap { data-> Result<[String: Any?], NetworkingError> in
                do {
                    guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        return .failure(.unknown(statusCode: (res as? HTTPURLResponse)?.statusCode ?? 0, data: data, error: err))
                    }
                    return .success(dict)
                } catch {
                    return .failure(.decodingFailed(data: data, error: error))
                }
            })
            
        }
        
    }
    
    /// Starts a URLSessionsData task with given data and decodes result to given type
    /// - Parameters:
    ///   - stringURL: url to request from
    ///   - method: HTTP Method i.e. GET, POST, ...
    ///   - headers: Headers of the request as Dictionary
    ///   - parameters: Parameters dictionary will be encoded in url in GET, DELETE requests, in body otherwise
    ///   - decodingType: Decodable Type to deocde data to on success
    ///   - decoder: JSONDecoder used in decoding operation
    ///   - validator: Range of status codes will pass as success, failure otherwise
    ///   - completion: Completion block with Result Type parameter to be fired on response received
    public static func request<T: Codable>(
            _ stringURL: String,
            _ method: HTTPMethod,
            headers: [String: String]? = nil,
            parameters: [String: Any]? = nil,
            decodingType: T.Type,
            decoder: JSONDecoder = JSONDecoder(),
            validator: ClosedRange<Int> = 200...299,
            completion: @escaping (Result<T, NetworkingError>)-> Void) {
        
        self.request(stringURL, method, headers: headers, parameters: parameters) { data, res, err in
            
            let validatedRes = ResponseValidator.validate(data: data, urlResponse: res, error: err, validator: validator)
            
            completion(validatedRes.flatMap { data-> Result<T, NetworkingError> in
                do {
                    return .success(try decoder.decode(decodingType.self, from: data))
                } catch {
                    return .failure(.decodingFailed(data: data, error: error))
                }
            })
            
        }
        
    }
    
    /// Starts a URLSessionsData task with given data and decodes result to given type
    /// - Parameters:
    ///   - request: Request object that contains url, method, headers, params used in request
    ///   - decodingType: Decodable Type to deocde data to on success
    ///   - decoder: JSONDecoder used in decoding operation
    ///   - validator: Range of status codes will pass as success, failure otherwise
    ///   - completion: Completion block with Result Type parameter to be fired on response received
    public static func request<T: Codable>(
            _ request: Request,
            decodingType: T.Type,
            decoder: JSONDecoder = JSONDecoder(),
            validator: ClosedRange<Int> = 200...299,
            completion: @escaping (Result<T, NetworkingError>)-> Void) {
    
        self.request(request.url, request.method,
                     headers: request.headers, parameters: request.parameters,
                     decodingType: decodingType, decoder: decoder,
                     validator: validator, completion: completion)
        
    }
    
    /// Starts a URLSessionsData task with given data
    /// - Parameters:
    ///   - stringURL: url to upload to
    ///   - objects: Array of objects to be uploaded
    ///   - headers: Headers of the request as Dictionary
    ///   - parameters: Parameters dictionary will be encoded as form data
    ///   - completion: Completion block to be fired on response received
    /// - Returns: The started data task as a discardable result to make manipulations/observations
    @discardableResult
    public static func upload(
            _ stringURL: String,
            objects: [Uploadable],
            headers: [String: String]? = nil,
            parameters: [String: String]? = nil,
            completion: @escaping (Data?, URLResponse?, Error?)-> Void)-> URLSessionDataTask? {
        
        let builder = MultipartRequestBuilder()
        
        var request: URLRequest!
        
        do {
            request = try builder.urlRequest(fromString: stringURL, objects: objects, params: parameters)
        } catch {
            completion(nil, nil, error)
            return nil
        }
        
        builder.setMethod(.post, forRequest: &request)
        
        var headers = headers
        headers?.removeValue(forKey: "Content-Type")
        builder.setHeaders(headers, forRequest: &request)
        
        let task = session.dataTask(with: request) { completion($0, $1, $2) }
        task.resume()
        return task
    }
    
}
