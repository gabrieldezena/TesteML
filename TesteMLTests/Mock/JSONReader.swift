//
//  JSONReader.swift
//  TesteMLTests
//
//  Created by Gabriel Pereira Dezena on 17/02/21.
//

import Foundation

class JSONReader {
    func readJSON(fileName: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        if let ressourceURL = testBundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: ressourceURL)
                return data
            } catch {
                return nil
            }
        }
        return nil
    }
}
