//
//  ProductsDataSource.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 06/02/21.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: productCellId, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        
        cell.title.text = "TESTEEEE"
        return cell
    }
}
