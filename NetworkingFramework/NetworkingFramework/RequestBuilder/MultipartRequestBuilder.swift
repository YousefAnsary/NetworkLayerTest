//
//  MulipartBuilder.swift
//  NetworkingFramework
//
//  Created by Yousef on 4/30/21.
//

import Foundation

internal final class MultipartRequestBuilder: URLRequestBuilder {
    
    func urlRequest(fromString urlString: String, objects: [Uploadable], params: [String : String]?) throws -> URLRequest {
        
        guard let url = URL(string: urlString) else { throw InvalidURL(url: urlString) }
        
        let boundary = "Boundary-\(NSUUID().uuidString)"
        let lineBreak = "\r\n"
        
        var urlRequest = URLRequest(url: url)
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        for object in objects {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(object.parameterName)\"; filename=\"\(object.name)\"\(lineBreak)")
            body.append("Content-Type: \(object.type + lineBreak + lineBreak)")
            body.append(object.data)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
    
}

extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
    
}

public struct Uploadable {
    public let data: Data
    public let name: String
    public let type: String
    public let parameterName: String
}
