//
//  ViewModelsTests.swift
//  TesteMLTests
//
//  Created by Gabriel Pereira Dezena on 06/02/21.
//

import XCTest
@testable import TesteML

class ViewModelsTests: XCTestCase {

    func testProductViewModel() {
        
        let product = Product(title: "Moto G6 Plus 64 Gb Nimbus 4 Gb Ram",
                              price: 300.1,
                              available_quantity: 2,
                              sold_quantity: 3,
                              condition: "new",
                              thumbnail: "www.teste.com.br",
                              buying_mode: "buy_it_now",
                              seller: Seller(permalink: "http://perfil.mercadolibre.com.ar/PEROZZI_E_HIJO"),
                              shipping: Shipping(free_shipping: true))
        
        let productViewModel = ProductViewModel(product: product)

        XCTAssertEqual(product.title, productViewModel.title)
        XCTAssertEqual("R$300,10", productViewModel.price)
        XCTAssertEqual(product.available_quantity, productViewModel.available_quantity)
        XCTAssertEqual(product.sold_quantity, productViewModel.sold_quantity)
        XCTAssertEqual("Novo", productViewModel.condition)
        XCTAssertEqual(product.thumbnail, productViewModel.thumbnail)
        XCTAssertEqual(product.buying_mode, productViewModel.buying_mode)
        XCTAssertEqual("VENDEDOR: PEROZZI_E_HIJO", productViewModel.seller)
        XCTAssertEqual("Frete Grátis", productViewModel.shipping)
    }
    
    func testErrorViewModel() {
        let genericErrorViewModel = ErrorViewModel(mlError: .genericError)
        let noProductsFoundErrorViewModel = ErrorViewModel(mlError: .noProductsFound)
        
        XCTAssertEqual(genericErrorViewModel.title, "Vixe...")
        XCTAssertEqual(genericErrorViewModel.subTitle,"Algo deu errado, tente novamente mais tarde.")
        XCTAssertEqual(genericErrorViewModel.image, UIImage(named: "warning"))

        XCTAssertEqual(noProductsFoundErrorViewModel.title, "Ops!")
        XCTAssertEqual(noProductsFoundErrorViewModel.subTitle, "Não encontramos nenhum produto com esse nome, tente pesquisar de outra forma.")
        XCTAssertEqual(noProductsFoundErrorViewModel.image, UIImage(named: "folder"))
    }

}
