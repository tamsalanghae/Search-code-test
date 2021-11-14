//  
//  ResultSearchViewController.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import UIKit
import Kingfisher
final class ResultSearchViewController: BaseViewController {
    // MARK: - Variables
    private var presenter = ResultSearchPresenter(model: ResultSearchModel())
    
    // MARK: - IBOutlet
    @IBOutlet private weak var contentImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var langugeLabel: UILabel!
    @IBOutlet private weak var watchesLabel: UILabel!
    @IBOutlet private weak var forkLabel: UILabel!
    @IBOutlet private weak var insuesLabel: UILabel!
    @IBOutlet private weak var starCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
    }
}

extension ResultSearchViewController {
    func displayResultScreen(_ data: SearchTableViewEntity.Results) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let url = URL(string: data.owner.avatarURL)
            self.contentImageView.kf.setImage(with: url)
            self.titleLabel.text = "Fullname: \(data.fullName)"
            self.langugeLabel.text = "Languge: \(data.language ?? "")"
            self.watchesLabel.text = "Watches: 0)"
            self.forkLabel.text = "Fork: \(data.forksCount)"
            self.insuesLabel.text = "Insues: \(data.openIssuesCount)"
            self.starCountLabel.text = "Star: \(data.stargazersCount)"
        }
        
    }
}

extension ResultSearchViewController: ResultSearchViewProtocol {
    // can't not run in here,
    func displayViewScreen(_ data: ResultSearchViewEntity) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let url = URL(string: data.owner.avatarURL)
            self.contentImageView.kf.setImage(with: url)
            self.titleLabel.text = "Fullname: \(data.fullName)"
            self.langugeLabel.text = "Languge: \(data.language ?? "")"
            self.watchesLabel.text = "Watches: 0)"
            self.forkLabel.text = "Fork: \(data.forksCount)"
            self.insuesLabel.text = "Insues: \(data.openIssuesCount)"
            self.starCountLabel.text = "Star: \(data.stargazersCount)"
        }


    }
}
