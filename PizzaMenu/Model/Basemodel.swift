//
//  Basemodel.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import Foundation
import Foundation

struct BaseModel: Codable {
    var data : DataModel?
}

struct DataModel: Codable  {
    var categories : [CategoryModel]?
}

struct CategoryModel: Codable , Identifiable{
    var id: Int?
    var title : String?
    var thumbnail: String?
    var items : [ItemListModel]?
}
struct ItemListModel: Codable,Identifiable {
    var id : Int?
    var name : String?
    var image : String?
    var description: String?
}

