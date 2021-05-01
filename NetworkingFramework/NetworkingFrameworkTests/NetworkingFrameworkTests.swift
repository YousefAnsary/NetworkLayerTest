//
//  NetworkingFrameworkTests.swift
//  NetworkingFrameworkTests
//
//  Created by Yousef on 5/1/21.
//

import XCTest
@testable import NetworkingFramework

class NetworkingFrameworkTests: XCTestCase {
    
    func testGet() throws {
        let expectation = self.expectation(description: "waiting api response")
        let url = "http://api.github.com/search/repositories"
        let searchKeyword = "authentication"
        let params = ["q": searchKeyword]
        
        NetworkingManager.request(url, .get, parameters: params) { (res: Result<[String: Any?], NetworkingError>) in
            switch res {
            case .success(let dict):
                let items = dict["items"] as? [[String: Any?]]
                XCTAssert((items?.count ?? 0) > 0, "No items fetched")
                expectation.fulfill()
            case .failure(let err):
                XCTFail(err.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 50)
        
    }
    
}
