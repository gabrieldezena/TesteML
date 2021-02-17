//
//  LoadingView.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 16/02/21.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - Views
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Override
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustLayout()
    }
    
    // MARK: - Public Functions

    func showActivityIndicatory(viewController: UIViewController, addOnController: Bool = false) {
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        self.addSubview(activityIndicator)
        
        addLoading(controller: viewController)
        activityIndicator.startAnimating()
        
        self.alpha = 0
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.alpha = 1
        })
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                self?.alpha = 0
            }, completion: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
                self?.removeFromSuperview()
            })
        }
    }
    
    // MARK: - Private Functions
    
    private func adjustLayout() {
        self.frame = UIScreen.main.bounds
        activityIndicator.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    }
    
    private func addLoading(controller viewController: UIViewController) {
        if let navigation = viewController.navigationController {
            navigation.view.addSubview(self)
        } else {
            viewController.view.addSubview(self)
        }
    }
}
