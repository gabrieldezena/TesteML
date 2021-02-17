//
//  ErrorView.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 17/02/21.
//

import SnapKit
import UIKit

protocol ErrorDelegate: AnyObject {
    func didTapCloseButton()
}

class ErrorView: UIView {
    
    // MARK: - Properties
    
    private weak var delegate: ErrorDelegate?
    
    // MARK: - Views

    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView(frame: .zero)
        return image
    }()
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Inits

    init(frame: CGRect = .zero, delegate: ErrorDelegate, errorViewModel: ErrorViewModel) {
        super.init(frame: frame)
        setupView()
        self.delegate = delegate
        self.fillView(errorViewModel: errorViewModel)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions

    private func fillView(errorViewModel: ErrorViewModel) {
        title.text = errorViewModel.title
        subtitle.text = errorViewModel.subTitle
        image.image = errorViewModel.image
    }
    
    @objc
    private func didTapCloseButton() {
        delegate?.didTapCloseButton()
    }
}

extension ErrorView: CodeView {
    func buildViewHierarchy() {
        addSubview(closeButton)
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        addSubview(contentView)
    }
    
    func setupConstraints() {
    
        let grid = 8
        
        closeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(grid * 2)
            make.top.equalToSuperview().offset(grid * 6)
            make.width.height.equalTo(24)
        }

        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(170)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(grid * 4)
            make.left.equalToSuperview().offset(grid * 3)
            make.right.equalToSuperview().inset(grid * 2)
        }

        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(grid * 2)
            make.left.equalToSuperview().offset(grid * 3)
            make.right.equalToSuperview().inset(grid * 2)
            make.bottom.equalToSuperview().inset(grid * 3)
        }
    }
}
