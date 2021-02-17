//
//  Coordinator.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 16/02/21.
//

import UIKit

protocol CoordinatorProtocol {
    func startViewController() -> UINavigationController
    func go(to controller: Controller<UIViewController>)
    func showLoadingView()
    func hideLoadingView()
}

enum Controller<T> {
    case productDetail(product: ProductViewModel)
    case errorView(error: ErrorViewModel)
}

class Coordinator: CoordinatorProtocol {
    
    private let loadingView = LoadingView()
    private var viewController = UIViewController()
    private var mainNavigationController = UINavigationController()

    func startViewController() -> UINavigationController {
        viewController = HomeViewController(coordinator: self)
        mainNavigationController = UINavigationController(rootViewController: viewController)
        return mainNavigationController
    }

    func go(to controller: Controller<UIViewController>) {
        switch controller {
        case .productDetail(let product):
            viewController = ProductDetailViewController(coordinator: self, product: product)
            mainNavigationController.pushViewController(viewController, animated: true)
        case .errorView(let error):
            viewController = ErrorViewController(coordinator: self, errorViewModel: error)
            mainNavigationController.topViewController?.present(viewController, animated: true)
        }
    }

    func showLoadingView() {
        guard let controller = mainNavigationController.topViewController else { return }
        loadingView.showActivityIndicatory(viewController: controller)
    }
    
    func hideLoadingView() {
        loadingView.hideActivityIndicator()
    }
}
