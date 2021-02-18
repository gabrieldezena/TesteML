//
//  ErrorViewController.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 17/02/21.
//

import UIKit

class ErrorViewController: UIViewController {
    
    // MARK: - Properties

    var errorViewModel: ErrorViewModel?
    var coordinator: CoordinatorProtocol?
    
    // MARK: - View

    lazy var errorView: ErrorView = {
        guard let error = errorViewModel else { return  ErrorView() }
        let view = ErrorView(delegate: self, errorViewModel: error)
        return view
    }()
    
    // MARK: - Inits

    convenience init(coordinator: CoordinatorProtocol, errorViewModel: ErrorViewModel) {
        self.init()
        self.errorViewModel = errorViewModel
        self.coordinator = coordinator
    }
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        setupView()
    }
    
    // MARK: - functions
    
    func setupView() {
        self.view = errorView
        view.backgroundColor = .white
    }
}

extension ErrorViewController: ErrorDelegate {
    func didTapCloseButton() {
        self.dismiss(animated: true)
    }
}
