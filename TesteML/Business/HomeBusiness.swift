//
//  HomeBusiness.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 08/02/21.
//

import Foundation

protocol HomeBusinessDelegate: AnyObject {
    func successFetchProducts(products: ProductList)
    func abortWithError(error: Error)
}

class HomeBusiness {
    
    private weak var delegate: HomeBusinessDelegate?
    private var provider: ApiProviderDelegate?
    
    init(delegate: HomeBusinessDelegate, provider: ApiProviderDelegate = ApiProvider()) {
        self.delegate = delegate
        self.provider = provider
    }
    
    func fetchProducts(params: [String: Any], product: String) {
        provider?.fetchProducts(params: params, product: product, completion: { result in
            switch result {
            case let .success(data):
                guard let jsonData = data else { return }
                if let products = try? JSONDecoder().decode(ProductList.self, from: jsonData) {
                    if products.results.isEmpty {
                        self.delegate?.abortWithError(error: MLError.noProductsFound)
                    } else {
                        self.delegate?.successFetchProducts(products: products)
                    }
                }
            case let .error(error):
                self.delegate?.abortWithError(error: error)
            }
        })
    }
}
