//
//  NetworkService.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import Foundation

enum ServerError: Error {
    case paramsError
    case noInternet
    case serverError // 500 - 503
    case error
}

protocol NetworkServiceProtocol {
    func getData(_ url: URL,
                 headers: [String: Any]?,
                 params: [String: Any]?,
                 result: @escaping (Result<Data, Error>) -> Void)

}
final class NetworkServices {
    private let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    /// Fetch data from API
    private var dataTask: URLSessionDataTask?
}

extension NetworkServices: NetworkServiceProtocol {
    
    func getData(_ url: URL, headers: [String : Any]?, params: [String : Any]?, result: @escaping (Result<Data, Error>) -> Void) {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let params = params {
            urlComponents?.queryItems = params.map({ (key, value) in
                URLQueryItem(name: key, value: "\(value)")
            })
        }
        guard let requestURL = urlComponents?.url else {
            result(.failure(ServerError.paramsError))
            return
            
        }
        var request = URLRequest(url: requestURL)
        
        if let headers = headers {
            for header in headers {
                request.setValue(header.value as? String, forHTTPHeaderField: header.key)
            }
        }
        dataTask = defaultSession.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print(error)
                result(.failure(ServerError.error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                result(.failure(ServerError.error))
                return
            }
            guard let data = data else {
                result(.failure(ServerError.error))
                return
            }
            result(.success(data))
        })
        dataTask?.resume()
    }
}
