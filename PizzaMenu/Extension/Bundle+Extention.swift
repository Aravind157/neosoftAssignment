//
//  Bundle+Extention.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 14/04/25.
//

import Foundation
extension Bundle {
    func getFileContent(named fileName: String, withExtension format: FileFormat) -> Data? {
        guard let url = self.url(forResource: fileName, withExtension: format.rawValue) else {
            print("\(fileName).\(format.rawValue)")
            return nil
        }

        do {
            return try Data(contentsOf: url)
        } catch {
            print("\(error.localizedDescription)")
            return nil
        }
    }
}
