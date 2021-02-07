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

    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
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

    // MARK: - Functions

}

extension ProductCell: CodeView {
    func buildViewHierarchy() {
        addSubview(title)
    }

    func setupConstraints() {
        title.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
