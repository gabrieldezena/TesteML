//
//  ErrorViewController.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 17/02/21.
//

import UIKit

class ErrorViewController: UIViewController {
    
    var errorViewModel: ErrorViewModel?
    var coordinator: CoordinatorProtocol?

    lazy var errorView: ErrorView = {
        guard let error = errorViewModel else { return  ErrorView() }
        let view = ErrorView(delegate: self, errorViewModel: error)
        return view
    }()

    convenience init(coordinator: Coordinator, errorViewModel: ErrorViewModel) {
        self.init()
        self.errorViewModel = errorViewModel
        self.coordinator = coordinator
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    private func setupView() {
        self.view = errorView
        view.backgroundColor = .white
    }
}

extension ErrorViewController: ErrorDelegate {
    func didTapCloseButton() {
        self.dismiss(animated: true)
    }
}
