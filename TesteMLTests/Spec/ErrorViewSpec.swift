//
//  ErrorViewSpec.swift
//  TesteMLTests
//
//  Created by Gabriel Pereira Dezena on 17/02/21.
//

import Nimble
import Nimble_Snapshots
import Quick
@testable import TesteML

class ErrorViewSpec: QuickSpec {
    
    override func spec() {

        var window: UIWindow?

        beforeEach {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
        }

        describe("the UI") {
            it("should have the same look and feel for noProductsFound", closure: {

                let errorViewModel = ErrorViewModel(mlError: .noProductsFound)
                let errorViewController = ErrorViewController(coordinator: self, errorViewModel: errorViewModel)

                window?.rootViewController = errorViewController
                errorViewController.setupView()
                expect(window?.rootViewController?.view) == snapshot("noProductsFound")
            })
        }
        
        describe("the UI") {
            it("should have the same look and feel for generic error", closure: {

                let errorViewModel = ErrorViewModel(mlError: .genericError)
                let errorViewController = ErrorViewController(coordinator: self, errorViewModel: errorViewModel)

                window?.rootViewController = errorViewController
                errorViewController.setupView()
                expect(window?.rootViewController?.view) == snapshot("genericError")
            })
        }
    }

}

extension ErrorViewSpec: CoordinatorProtocol {
    func startViewController() -> UINavigationController { return UINavigationController() }
    func go(to controller: Controller<UIViewController>) {}
    func showLoadingView() {}
    func hideLoadingView() {}
}
