//
//  HomeBusinessTests.swift
//  TesteMLTests
//
//  Created by Gabriel Pereira Dezena on 17/02/21.
//

import XCTest
@testable import TesteML

class HomeBusinessTests: XCTestCase {
    
    private var successToFetcProductsExpectation = XCTestExpectation()
    private var noProductsFoundExpectation = XCTestExpectation()
    private var genericErrorExpectation = XCTestExpectation()

    func testFetchProductsSuccess() {
        let provider = ApiProviderMock(fileName: "Success")
        let business = HomeBusiness(delegate: self, provider: provider)
        
        business.fetchProducts(product: String())
        wait(for: [successToFetcProductsExpectation], timeout: 2)

    }
    
    func testNoProductsFound() {
        let provider = ApiProviderMock(fileName: "EmptyResult")
        let business = HomeBusiness(delegate: self, provider: provider)
        
        business.fetchProducts(product: String())
        wait(for: [noProductsFoundExpectation], timeout: 2)
    }
    
    func testGenericError() {
        let provider = ApiProviderMock(fileName: "GenericError")
        let business = HomeBusiness(delegate: self, provider: provider)
        
        business.fetchProducts(product: String())
        wait(for: [genericErrorExpectation], timeout: 2)
    }
}

extension HomeBusinessTests: HomeBusinessDelegate {
    func successFetchProducts(products: ProductList) {
        successToFetcProductsExpectation.fulfill()
    }
    
    func abortWithError(error: Error) {
        let error = error as? MLError
        
        switch error {
        case .noProductsFound:
            noProductsFoundExpectation.fulfill()
        case .genericError:
            genericErrorExpectation.fulfill()
        case .none:
            print("error")
        }
    }
}
