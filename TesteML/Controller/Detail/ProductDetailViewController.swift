//
//  ProductDetailViewController.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 16/02/21.
//

import UIKit

class ProductDetailViewController: UIViewController {

    // MARK: - Properties

    var coordinator: CoordinatorProtocol?
    var product: ProductViewModel?
    
    // MARK: - Views

    lazy var productDetailView: ProductDetailView = {
        let view = ProductDetailView()
        return view
    }()

    // MARK: - Inits

    convenience init(coordinator: CoordinatorProtocol, product: ProductViewModel) {
        self.init()
        self.coordinator = coordinator
        self.product = product
    }
    
    // MARK: - Overrides

    override func viewDidLoad() {
        self.setupView()
    }
    
    // MARK: - Private functions

    private func setupView() {
        view.backgroundColor = .white
        self.view = productDetailView
        productDetailView.fillView(product: self.product)
    }
}
