//
//  Constants.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//
import Foundation

class JsonParser {
    static func decodeJson<T: Codable>(from data: Data, in type: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("\(error)")
            return nil
        }
    }
}
