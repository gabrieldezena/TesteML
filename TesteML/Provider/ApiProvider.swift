//
//  ApiProvider.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 08/02/21.
//

import Foundation
import Alamofire

public enum Result<String, T> {
    case success(String?, Data?)
    case error(String?, Error)
}

typealias CompletionCallBack = (Result<String?, Any>) -> Void

protocol ApiProviderDelegate: AnyObject {
    func fetchProducts(params: [String: Any], product: String, completion: @escaping CompletionCallBack)
}

class ApiProvider: ApiProviderDelegate {

    func fetchProducts(params: [String: Any], product: String, completion: @escaping CompletionCallBack) {
        let urlString = "https://api.mercadolibre.com/sites/MLB/search?q=\(product)"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded) {

            AF.request(url, method: .get, parameters: params).validate().responseJSON { (result) in
                if result.error != nil {
                    print("Error: \(String(describing: result.error))")
                } else {
                    completion(.success(nil, result.data))
                }
            }
        }
    }
}
