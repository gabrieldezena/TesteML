//
//  ProductsDataSource.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 06/02/21.
//

import UIKit
import Kingfisher

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: productCellId, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        
        cell.title.text = products[indexPath.row].title
        cell.price.text = products[indexPath.row].price
        cell.shipping.text = products[indexPath.row].shipping

        let url = URL(string: self.products[indexPath.row].thumbnail)
        cell.productImage.kf.setImage(with: url)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(product: self.products[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
