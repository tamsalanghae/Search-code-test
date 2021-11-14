//  
//  ResultSearchContract.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import Foundation

protocol ResultSearchContract {
    typealias Model = ResultSearchModelProtocol
    typealias View = ResultSearchViewProtocol
    typealias Presenter = ResultSearchPresenterProtocol
}

protocol ResultSearchModelProtocol {
    
}

protocol ResultSearchViewProtocol: AnyObject {
    func displayViewScreen(_ data: ResultSearchViewEntity)
}

protocol ResultSearchPresenterProtocol {
    func attach(view: ResultSearchContract.View)
    func detachView()
    
    func displayResultScreen(_ data: SearchTableViewEntity.Results)
}
