//
//  Constants.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import Foundation
import UIKit

enum ColorConstants {
    static let ceruleanBlue = UIColor(hex: "#2C98F0")
    static let muteSage = UIColor(hex: "#ABB0AE")
    static let lightGray = UIColor(hex: "#E5EBEA")
    static let lightAqua = UIColor(hex: "#CDE8E1")
}

enum StringConstants {
    static let CANCEL = "Cancel"
    static let SEARCH = "Search"
    static let ITEMS = "items"
}

enum ImageConstant {
    static let placeholder_image = "placeholder_image"
    static let ellipsis = "ellipsis"
    static let search = "magnifyingglass"
    static let cancel = "xmark.circle.fill"
    static let ellipsis_vertical = "menu"

    
    
}

enum FileName {
    static let pizzaJson = "PizzaJson"
}

enum FileFormat: String{
    case json = "json"
}
