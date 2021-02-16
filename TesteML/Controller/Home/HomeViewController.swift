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
    var searchController: UISearchController?
    let productCellId = "ProductCellId"

    var products: [ProductViewModel] = [] {
        didSet {
            homeView.productsTableView.reloadData()
            homeView.productsTableView.layoutIfNeeded()
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
        searchController = UISearchController(searchResultsController: nil)
        searchController?.delegate = self

        let scb = self.searchController?.searchBar
        scb?.placeholder = "Buscar"
        scb?.delegate = self

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

    func didSelect() {
        coordinator?.go(to: .productDetail)
    }

    private func createProductViewModels(with products: ProductList) -> [ProductViewModel] {
        var productList: [ProductViewModel] = []
        for product in products.results {
            productList.append(ProductViewModel(product: product))
        }

        return productList
    }
}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController?.dismiss(animated: true, completion: nil)
        coordinator?.showLoadingView()
        business.fetchProducts(product: searchBar.text ?? String())
    }
}

extension HomeViewController: HomeBusinessDelegate {
    func successFetchProducts(products: ProductList) {
        let productsViewModal = createProductViewModels(with: products)
        self.products = productsViewModal
        coordinator?.hideLoadingView()
    }

    func abortWithError(error: Error) {
        print(error)
    }
}

class ProductDetailViewController: UIViewController {

    var coordinator: CoordinatorProtocol?

    convenience init(coordinator: CoordinatorProtocol) {
        self.init()
        self.coordinator = coordinator
    }
}

