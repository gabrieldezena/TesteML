//
//  ProductCell.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 06/02/21.
//

import SnapKit
import UIKit

class ProductCell: UITableViewCell {

    // MARK: - Views
    
    lazy var productImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var shipping: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGreen
        return label
    }()

    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductCell: CodeView {
    func buildViewHierarchy() {
        addSubview(productImage)
        addSubview(title)
        addSubview(price)
        addSubview(shipping)
    }

    func setupConstraints() {
        
        let grid = 8
    
        productImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(grid)
            make.top.equalToSuperview().offset(grid)
            make.height.width.equalTo(80)
        }
        
        title.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).offset(grid)
            make.right.equalToSuperview().inset(grid)
            make.top.equalTo(productImage.snp.top)
        }
        
        price.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).offset(grid)
            make.right.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(grid)
        }
        
        shipping.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).offset(grid)
            make.right.equalToSuperview()
            make.top.equalTo(price.snp.bottom).offset(grid)
            make.bottom.equalToSuperview().inset(grid)
        }
    }
}
