//
//  ApiProvider.swift
//  TesteML
//
//  Created by Gabriel Pereira Dezena on 08/02/21.
//

import Foundation
import Alamofire

enum Result<String, T> {
    case success(Data?)
    case error(Error)
}

enum MLError: Error {
    case genericError
    case noProductsFound
}

typealias CompletionCallBack = (Result<String?, Any>) -> Void

protocol ApiProviderDelegate: AnyObject {
    func fetchProducts(product: String, completion: @escaping CompletionCallBack)
}

class ApiProvider: ApiProviderDelegate {

    func fetchProducts(product: String, completion: @escaping CompletionCallBack) {
        let urlString = "https://api.mercadolibre.com/sites/MLB/search?q=\(product)"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded) {

            AF.request(url, method: .get).validate().responseJSON { result in
               completion(self.handleResult(result: result))
            }
        }
    }
    
    func handleResult(result: AFDataResponse<Any>) -> Result<String?, Any> {
        if let error = result.error {
            self.hundleError(error: error)
            return .error(MLError.genericError)
        }
        return.success(result.data)
    }

    func hundleError(error: AFError) {
        switch error {
        case .invalidURL(let url):
            print("Invalid URL: \(url) - \(error.localizedDescription)")
        case .parameterEncodingFailed(let reason):
            print("Parameter encoding failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .multipartEncodingFailed(let reason):
            print("Multipart encoding failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .responseValidationFailed(let reason):
            print("Response validation failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
            
            switch reason {
            case .dataFileNil, .dataFileReadFailed:
                print("Downloaded file could not be read")
            case .missingContentType(let acceptableContentTypes):
                print("Content Type Missing: \(acceptableContentTypes)")
            case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
            case .unacceptableStatusCode(let code):
                print("Response status code was unacceptable: \(code)")
            case .customValidationFailed(let error):
                print("Custom Validation failed: \(error.localizedDescription)")
            }
        case .responseSerializationFailed(let reason):
            print("Response serialization failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .createUploadableFailed(let error):
            print("Create uploadable failed: \(error.localizedDescription)")
        case .createURLRequestFailed(let error):
            print("Create url request failed: \(error.localizedDescription)")
        case .downloadedFileMoveFailed:
            print("Downloaded file move failed")
        case .explicitlyCancelled:
            print("Explicitly cancelled")
        case .parameterEncoderFailed(let reason):
            print("Parameter encoder failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .requestAdaptationFailed(let error):
            print("Request Adaptation failed: \(error.localizedDescription)")
        case .requestRetryFailed:
            print("Request retry failed")
        case .serverTrustEvaluationFailed(let reason):
            print("Server trust evaluation failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .sessionDeinitialized:
            print("Session deinitialized")
        case .sessionInvalidated(let error):
            print("Session invalidated: \(error?.localizedDescription ?? String())")
        case .sessionTaskFailed(let error):
            print("Session task failed: \(error.localizedDescription)")
        case .urlRequestValidationFailed(let reason):
            print("Url request validation failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        }
    }
}
