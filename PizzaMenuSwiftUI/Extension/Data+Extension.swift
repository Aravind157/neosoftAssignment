//
//  Data+Extension.swift
//  PizzaMenuSwiftUI
//
//  Created by aravind  yadav on 14/04/25.
//

import Foundation

extension Data {
    func decode<T: Decodable>(to type: T.Type) -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
