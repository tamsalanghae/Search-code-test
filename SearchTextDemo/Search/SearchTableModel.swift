//  
//  SearchTableModel.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import Foundation

struct SearchTableViewEntity {
    let totalCount: Int
    let incompleteResults: Bool
    let results: [Results]
    struct Results {
        let stargazersCount: Int
        let openIssuesCount: Int
        let language: String?
        let fullName: String
        let forksCount: Int
        let owner: Owner
        struct Owner {
            let id: Int
            let avatarURL: String
        }
    }
}

final class SearchTableModel {
    private let listMovieAPIFetcher: ListMoviesAPIFetcher = ListMoviesAPIFetcher()
}

extension SearchTableModel: SearchTableModelProtocol {
    func findKeyword(_ key: String, result: @escaping (Result<ListKeywordAPIResponse, Error>) -> Void) {
        listMovieAPIFetcher.findKeyWordByKey(key) { [weak self] resultResponse in
            guard let self = self else {
                return
            }
            switch resultResponse {
            case .failure(let error):
                result(.failure(error))
            case  .success(let data):
                if let listMovies = self.convertData(data) {
                    result(.success(listMovies))
                }else {
                    result(.failure(APIError.dataError))
                }
            }
        }
    }
}

extension SearchTableModel {
    private func convertData(_ data: Data) -> ListKeywordAPIResponse? {
        let decoder = JSONDecoder()

        var responseEntity: ListKeywordAPIResponse?

        do {
            responseEntity = try decoder.decode(ListKeywordAPIResponse.self, from: data)
            return responseEntity
        } catch let error {
            print("Failed to decode JSON \(error)")
            return nil
        }
    }

}
