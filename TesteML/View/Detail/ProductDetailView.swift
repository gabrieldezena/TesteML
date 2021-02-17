//
//  ProductDetailView.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 16/02/21.
//

import Kingfisher
import SnapKit
import UIKit

class ProductDetailView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        return contentView
    }()

    lazy var condition: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView(frame: .zero)
        return image
    }()

    lazy var seller: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillView(product: ProductViewModel?) {
        condition.text = product?.condition
        title.text = product?.title
        image.kf.setImage(with: URL(string: product?.thumbnail ?? String()))
        seller.text = product?.seller
        price.text = product?.price
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }
}

extension ProductDetailView: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(condition)
        contentView.addSubview(title)
        contentView.addSubview(image)
        contentView.addSubview(seller)
        contentView.addSubview(price)
    }
    
    func setupConstraints() {
        
        let grid = 8
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }

        condition.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(grid * 2)
            make.right.equalToSuperview().inset(grid * 2)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(condition.snp.bottom).offset(grid * 2)
            make.left.equalToSuperview().offset(grid * 2)
            make.right.equalToSuperview().inset(grid * 2)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(grid * 2)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(grid * 2)
            make.left.equalToSuperview().offset(grid * 2)
            make.right.equalToSuperview().inset(grid * 2)
        }
        
        seller.snp.makeConstraints { make in
            make.top.equalTo(price.snp.bottom).offset(grid)
            make.left.equalToSuperview().offset(grid * 2)
            make.right.equalToSuperview().inset(grid * 2)
        }
    }
}
