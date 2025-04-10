//
//  Constants.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import Foundation



struct FileManagerHelper {
    static func getFileContent(with fileName: String, and format: FileFormat) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: format.rawValue) else {
            print("❌ File not found: \(fileName).\(format.rawValue)")
            return nil
        }

        do {
            return try Data(contentsOf: url)
        } catch {
            print("❌ Error reading file: \(error.localizedDescription)")
            return nil
        }
    }
}
