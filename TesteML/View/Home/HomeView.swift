//
//  HomeView.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 06/02/21.
//

import SnapKit
import UIKit

class HomeView: UIView {
    
    // MARK: - Properties

    private let productCellId = "ProductCellId"

    // MARK: - Views

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    lazy var scrollViewContentView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    lazy var productsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120  
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        tableView.separatorColor = .gray
        tableView.register(ProductCell.self, forCellReuseIdentifier: productCellId)
        return tableView
    }()
    
    // MARK: - Inits

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    override func updateConstraints() {
        productsTableView.snp.updateConstraints { make in
            make.height.equalTo(productsTableView.contentSize.height)
        }

        super.updateConstraints()
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

extension HomeView: CodeView {

    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollViewContentView.addSubview(productsTableView)
        scrollView.addSubview(scrollViewContentView)
    }
    
    func setupConstraints() {
        
        let grid = 8
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        scrollViewContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }

        productsTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(grid)
            make.bottom.equalToSuperview().inset(grid)
            make.height.equalTo(0)
        }
    }
}
