//
//  Repository.swift
//  GithubClient
//
//  Created by Yousef on 4/7/21.
//

import Foundation

struct Repository: Codable {
    let id: Int?
    let name, fullName: String?
    let owner: Owner?
    let htmlURL: String?
    let itemDescription: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
        case itemDescription = "description"
        case url
    }
}
