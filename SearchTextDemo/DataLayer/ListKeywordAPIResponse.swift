//
//  ListKeywordResponse.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import Foundation

struct ListKeywordAPIResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    //MARK: - Item
    struct Item: Codable {
        let stargazersCount: Int
        let openIssuesCount: Int
        let language: String?
        let fullName: String
        let forksCount: Int
        let owner: Owner
        
        enum CodingKeys: String, CodingKey {
            case language
            case stargazersCount = "stargazers_count"
            case forksCount = "forks_count"
            case fullName = "full_name"
            case openIssuesCount = "open_issues_count"
            case owner
        }
        // MARK: - Owner
        struct Owner: Codable {
            let id: Int
            let avatarURL: String
            enum CodingKeys: String, CodingKey {
                case id
                case avatarURL = "avatar_url"
            }

        }

    }
}
