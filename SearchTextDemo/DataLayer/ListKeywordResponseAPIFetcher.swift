//
//  ListKeywordResponseAPIFetcher.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import Foundation
enum APIError: Error {
    case paramsError
    case authenError
    case dataError
    case urlError
}
protocol ListMoviesAPIFetcherProtocol  {
    func findKeyWordByKey(_ key: String, result: @escaping(Result<Data, APIError>) -> Void)
}
final class ListMoviesAPIFetcher {
    private let networkServices = NetworkServices()
}

extension ListMoviesAPIFetcher: ListMoviesAPIFetcherProtocol {
    func findKeyWordByKey(_ key: String, result: @escaping (Result<Data, APIError>) -> Void) {
        guard let url = URL(string: "https://api.github.com/search/repositories") else {
            result(.failure(APIError.dataError))
            return
        }
        // Keychain and param to search
        let params = ["q": key]
        networkServices.getData(url, headers: nil, params: params) { requestResult in
            switch requestResult {
            case .failure(let error):
                print("Error to get run URL Session: \(error)")
                result(.failure(APIError.dataError))
            case .success(let data):
                result(.success(data))
            }
        }
    }
}
