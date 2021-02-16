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
    case productDetail
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
        case .productDetail:
            viewController = ProductDetailViewController(coordinator: self)
        }
        mainNavigationController.pushViewController(viewController, animated: true)
    }
    
    func showLoadingView() {
        guard let controller = mainNavigationController.topViewController else { return }
        loadingView.showActivityIndicatory(viewController: controller)
    }
    
    func hideLoadingView() {
        loadingView.hideActivityIndicator()
    }
}
