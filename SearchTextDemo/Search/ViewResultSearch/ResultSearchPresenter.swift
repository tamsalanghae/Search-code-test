//  
//  ResultSearchPresenter.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import Foundation

final class ResultSearchPresenter {
    private weak var contentView: ResultSearchContract.View?
    private var model: ResultSearchContract.Model

    init(model: ResultSearchContract.Model) {
        self.model = model
    }
}

extension ResultSearchPresenter: ResultSearchPresenterProtocol {
    func displayResultScreen(_ data: SearchTableViewEntity.Results) {
        // conver Entity
        let result = ResultSearchViewEntity(stargazersCount: data.stargazersCount,
                                            openIssuesCount: data.openIssuesCount,
                                            language: data.language,
                                            fullName: data.fullName,
                                            forksCount: data.forksCount,
                                            wactches: 0,
                                            owner: ResultSearchViewEntity.Owner(id: data.owner.id,
                                                                                avatarURL: data.owner.avatarURL))
        contentView?.displayViewScreen(result)
    }
    func attach(view: ResultSearchContract.View) {
        contentView = view
    }
    
    func detachView() {
        contentView = nil
    }
}
