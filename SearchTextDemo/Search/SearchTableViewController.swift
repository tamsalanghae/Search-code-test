//  
//  SearchTableViewController.swift
//  SearchTextDemo
//
//  Created by Apple on 12/11/2021.
//

import UIKit

final class SearchTableViewController: BaseViewController {
    // MARK: - Variables
    private var presenter = SearchTablePresenter(model: SearchTableModel())
    
    // MARK: - IBOutlet
    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var searchText: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.attach(view: self)
        presenter.viewDidLoad()
        commonSetupTableView()
        commonSetupSearchBar()
        
    }
}

extension SearchTableViewController {
    private func commonSetupTableView() {
        // delegate
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // register
        let nib = UINib(nibName: "SearchViewCell", bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: "SearchViewCell")
    }
    private func commonSetupSearchBar() {
        //delegate
        searchText.delegate = self
    }
}

extension SearchTableViewController: SearchTableViewProtocol {
    func pushScreen(_ data: SearchTableViewEntity.Results) {
        let stroryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = stroryboard.instantiateViewController(withIdentifier: "ResultSearchViewController") as! ResultSearchViewController
        vc.displayResultScreen(data)
        navigationController?.pushViewController(vc, animated: true)
        
        print("Push Done: \(data)")
    }
func displayScreen() {
    DispatchQueue.main.async { [weak self] in
        self?.searchTableView.reloadData()
    }
}

func displayError(_ message: String) {
    print(message)
}
}

// MARK: - TableView Delegate
extension SearchTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.pushToResultScreen(indexPath.row)
    }
}

// MARK: - TableView Datasource
extension SearchTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberOfItem(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchViewCell") as! SearchViewCell
        let data = presenter.getEntityForCell(indexPath.section, indexPath.row)
        cell.displayMovieCell(data)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.findMovies(searchBar.text ?? "")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.findMovies(searchBar.text ?? "")
    }
}
