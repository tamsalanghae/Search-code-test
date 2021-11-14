//  
//  SearchTablePresenter.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import Foundation

final class SearchTablePresenter {
    private weak var contentView: SearchTableContract.View?
    private var model: SearchTableContract.Model
    private var listSearch: SearchTableViewEntity?
    init(model: SearchTableContract.Model) {
        self.model = model
    }
}

extension SearchTablePresenter: SearchTablePresenterProtocol {
    func pushToResultScreen(_ index: Int) {
        guard  let data = listSearch?.results[index] else {
            print("Can not push")
            return
        }
        contentView?.pushScreen(data)
    }
    
    func findMovies(_ key: String) {
        if  key == "" {
            contentView?.displayScreen()
        } else {
            model.findKeyword(key) { [weak self] response in
                guard let self = self else {
                    return
                }
                
                switch response {
                case .failure(let error):
                    self.contentView?.displayError("\(error)")
                case .success(let response):
                    if let data = self.convertToSearchMovieEntity(response) {
                        self.listSearch = data
                    } else {
                        self.listSearch = nil
                    }
                    self.contentView?.displayScreen()
                }
            }
        }
    }
    
    func viewDidLoad() {
        
    }
    
    func getNumberOfItem(_ section: Int) -> Int {
        listSearch?.results.count ?? 0
    }
    
    func getEntityForCell(_ section: Int, _ row: Int) -> SearchViewCell.SearchCellCustomEntity {
        guard  let data = listSearch?.results[row] else {
            return SearchViewCell.SearchCellCustomEntity(fullName: "----", languge: "-----")
        }
        return SearchViewCell.SearchCellCustomEntity(fullName: data.fullName, languge: data.language ?? "")
    }
    
    func attach(view: SearchTableContract.View) {
        contentView = view
    }
    
    func detachView() {
        contentView = nil
    }
}

extension SearchTablePresenter {
    func convertToSearchMovieEntity(_ data: ListKeywordAPIResponse) -> SearchTableViewEntity? {
        let result = SearchTableViewEntity(totalCount: data.totalCount, incompleteResults: data.incompleteResults, results: data.items.map({ keyword in
            SearchTableViewEntity.Results(stargazersCount: keyword.stargazersCount,
                                          openIssuesCount: keyword.openIssuesCount,
                                          language: keyword.language,
                                          fullName: keyword.fullName,
                                          forksCount: keyword.forksCount,
                                          owner: SearchTableViewEntity.Results.Owner(id: keyword.owner.id,
                                                                                     avatarURL: keyword.owner.avatarURL))
        }))
        return result
    }
}
