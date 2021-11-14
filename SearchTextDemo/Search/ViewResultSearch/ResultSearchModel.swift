//  
//  ResultSearchModel.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import Foundation

struct ResultSearchViewEntity {
    let stargazersCount: Int
    let openIssuesCount: Int
    let language: String?
    let fullName: String
    let forksCount: Int
    let wactches: Int?
    let owner: Owner
    struct Owner {
        let id: Int
        let avatarURL: String
    }

}

final class ResultSearchModel {
    
}

extension ResultSearchModel: ResultSearchModelProtocol {
    
}
