//
//  PizzaViewModel.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import Foundation
import SwiftUI

final class ItemsViewModel: ObservableObject {
    enum Section: Int, CaseIterable {
        case top
        case list
    }
    
    @Published var categories: [CategoryModel] = []
    @Published var selectedIndex: Int = 0
    @Published var isEditing: Bool = false
    @Published var searchText: String = ""
    
    var reloadData: ((Bool) -> Void)?
    
    var filteredItems: [ItemListModel] {
        guard categories.indices.contains(selectedIndex) else { return [] }
        let currentItems = categories[selectedIndex].items ?? []
        
        guard !searchText.isEmpty else { return currentItems }
        
        return currentItems.filter {
            $0.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
    
    var topThreeCharacters: [[Character: Int]] {
        let names = filteredItems.compactMap { $0.name }.joined()
        var countDict: [Character: Int] = [:]
        
        for char in names where char != " " {
            countDict[char, default: 0] += 1
        }
        
        return countDict
            .sorted { $0.value > $1.value }
            .prefix(3)
            .map { [$0.key: $0.value] }
    }
    
    func getData() {
        guard let rawData = Bundle.main.getFileContent(named: FileName.pizzaJson, withExtension: .json),
              let decoded: BaseModel = rawData.decode(to: BaseModel.self) else {
            categories = []
            reloadData?(false)
            return
        }
        
        categories = decoded.data?.categories ?? []
        reloadData?(false)
    }
    
    func getSelectedCategoryName() -> String {
        guard categories.indices.contains(selectedIndex) else { return "" }
        return categories[selectedIndex].title ?? ""
    }
}
