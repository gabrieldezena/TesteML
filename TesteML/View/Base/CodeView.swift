//
//  CodeView.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 06/02/21.
//

import Foundation

@objc protocol CodeView: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    @objc
    optional func setupAdditionalConfiguration()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        if let setupAdditionalConfiguration = setupAdditionalConfiguration {
            setupAdditionalConfiguration()
        }
    }
}
