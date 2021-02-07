//
//  HomeViewController.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 06/02/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    var searchController : UISearchController?
    let productCellId = "ProductCellId"

    lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.view.setNeedsUpdateConstraints()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        self.view = homeView
        homeView.productsTableView.delegate = self
        homeView.productsTableView.dataSource = self
    }
    
    private func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.delegate = self
        searchController?.searchResultsUpdater = self

        let scb = self.searchController?.searchBar
        scb?.tintColor = UIColor.white
        scb?.placeholder = "SEARCH"
        scb?.barTintColor = UIColor.white

        if let textfield = scb?.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.green
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
        }

        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            homeView.productsTableView.tableHeaderView = searchController?.searchBar
            searchController?.searchBar.tintColor = UIColor.green
            searchController?.searchBar.barTintColor = UIColor.green
        }
        definesPresentationContext = true
    }
}

extension HomeViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
