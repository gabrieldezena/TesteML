//
//  ProductDetailViewController.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 16/02/21.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var coordinator: CoordinatorProtocol?
    var product: ProductViewModel?
    
    lazy var productDetailView: ProductDetailView = {
        let view = ProductDetailView()
        return view
    }()

    convenience init(coordinator: CoordinatorProtocol, product: ProductViewModel) {
        self.init()
        self.coordinator = coordinator
        self.product = product
    }
    
    override func viewDidLoad() {
        self.setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        self.view = productDetailView
        productDetailView.fillView(product: self.product)
    }
}
