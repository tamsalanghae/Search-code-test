//
//  SearchViewCell.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import UIKit
protocol ResultSearchCellProtocol {
    func displayMovieCell(_ data: SearchViewCell.SearchCellCustomEntity )

}
class SearchViewCell: UITableViewCell {
    @IBOutlet private weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension SearchViewCell: ResultSearchCellProtocol {
    func displayMovieCell(_ data: SearchCellCustomEntity) {
        contentLabel.text = "\(data.fullName) / \(data.languge)"
    }
}

extension SearchViewCell {
    struct SearchCellCustomEntity {
        let fullName: String
        let languge: String
    }
}
