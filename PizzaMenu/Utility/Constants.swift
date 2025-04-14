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
    static let Default_Configuration = "Default Configuration"
}

enum ImageConstant {
    static let placeholder_image = "placeholder_image"
    
    
}

enum FileName {
    static let pizzaJson = "PizzaJson"
}

enum FileFormat: String{
    case json = "json"
}

enum Identifier {
    static let categoryCollectionViewCell =  "CategoryCollectionViewCell"
    static let searchView =  "SearchView"
    static let categoryTableViewCell =  "CategoryTableViewCell"
    static let itemListTableViewCell = "ItemListTableViewCell"
}

