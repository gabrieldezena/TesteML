//
//  HomeViewController.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 06/02/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var business = HomeBusiness(delegate: self)
    private var coordinator: CoordinatorProtocol?
    private var params: [String: Any] = ["limit": 50,
                                         "offset": 0]
    let productCellId = "ProductCellId"
    var searchController: UISearchController?
    var products: [ProductViewModel] = [] {
        didSet {
            homeView.productsTableView.layoutIfNeeded()
            homeView.productsTableView.reloadData()
            homeView.updateConstraints()
        }
    }

    lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()

    convenience init(coordinator: CoordinatorProtocol) {
        self.init()
        self.coordinator = coordinator
    }

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
        self.navigationController?.navigationBar.barTintColor = .yellow
        searchController = UISearchController(searchResultsController: nil)
        searchController?.delegate = self
        searchController?.searchResultsUpdater = self

        let scb = self.searchController?.searchBar
        scb?.placeholder = "Buscar"
        scb?.delegate = self
        scb?.backgroundColor = .yellow

        if let textfield = scb?.value(forKey: "searchField") as? UITextField {
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

    func didSelect(product: ProductViewModel) {
        coordinator?.go(to: .productDetail(product: product))
    }

    private func createProductViewModels(with products: ProductList) -> [ProductViewModel] {
        var productList: [ProductViewModel] = []
        for product in products.results {
            productList.append(ProductViewModel(product: product))
        }

        return productList
    }
}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if self.products.count > 0 {
            self.products.removeAll()
            homeView.productsTableView.reloadData()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController?.dismiss(animated: true, completion: nil)
        coordinator?.showLoadingView()
        business.fetchProducts(params: params, product: searchBar.text ?? String())
    }
}

extension HomeViewController: HomeBusinessDelegate {
    func successFetchProducts(products: ProductList) {
        coordinator?.hideLoadingView()
        let productsViewModal = createProductViewModels(with: products)
        self.products = productsViewModal
    }

    func abortWithError(error: Error) {
        coordinator?.hideLoadingView()
        print(error)
    }
}
