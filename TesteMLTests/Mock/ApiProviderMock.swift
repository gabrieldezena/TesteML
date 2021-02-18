//
//  ApiProviderMock.swift
//  TesteMLTests
//
//  Created by Gabriel Pereira Dezena on 17/02/21.
//

import Foundation
@testable import TesteML

class ApiProviderMock: ApiProviderDelegate {
    
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func fetchProducts(product: String, completion: @escaping CompletionCallBack) {
        let jsonReader = JSONReader()
        if let data = jsonReader.readJSON(fileName: fileName) {
            completion(.success(data))
        } else {
            completion(.error(MLError.genericError))
        }
    }
}
