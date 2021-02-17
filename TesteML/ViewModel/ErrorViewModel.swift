//
//  ErrorViewModel.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 17/02/21.
//

import UIKit

class ErrorViewModel {
        
    lazy var title: String = {
        let string = String()
        return string
    }()
    
    lazy var subTitle: String = {
        let string = String()
        return string
    }()
    
    lazy var image: UIImage = {
        let image = UIImage(named: "warning") ?? UIImage()
        return image
    }()
    
    init(mlError: MLError) {
        switch mlError {
        case .genericError:
            fillGenericError()
        case .noProductsFound:
            fillNoProductsFound()
        }
    }
    
    private func fillGenericError() {
        title = "Vixe..."
        subTitle = "Algo deu errado, tente novamente mais tarde."
    }
    
    private func fillNoProductsFound() {
        title = "Ops!"
        subTitle = "Não encontramos nenhum produto com esse nome, tente pesquisar de outra forma."
        image = UIImage(named: "folder") ?? UIImage()
    }
}
