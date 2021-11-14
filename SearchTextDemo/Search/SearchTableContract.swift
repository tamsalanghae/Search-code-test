//  
//  SearchTableContract.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import Foundation

protocol SearchTableContract {
    typealias Model = SearchTableModelProtocol
    typealias View = SearchTableViewProtocol
    typealias Presenter = SearchTablePresenterProtocol
}

protocol SearchTableModelProtocol {
    func findKeyword(_ key: String, result: @escaping (Result<ListKeywordAPIResponse, Error>) -> Void)
}

protocol SearchTableViewProtocol: AnyObject {
    func displayScreen()
    func displayError(_ message: String)
    func pushScreen(_ data: SearchTableViewEntity.Results)
}

protocol SearchTablePresenterProtocol {
    func attach(view: SearchTableContract.View)
    func detachView()
    
    func pushToResultScreen(_ index: Int)
    func findMovies(_ key: String)
    func viewDidLoad()
    func getNumberOfItem(_ section: Int) -> Int
    func getEntityForCell(_ section: Int, _ row: Int) -> SearchViewCell.SearchCellCustomEntity
}
