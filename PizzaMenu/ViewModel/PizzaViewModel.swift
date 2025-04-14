//
//  PizzaViewModel.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import Foundation

final class ItemsViewModel: ObservableObject {
    
    // MARK: - Section Enum
    enum Section: Int, CaseIterable {
        case top
        case list
    }
    
    // MARK: - Properties
    private(set) var categories: [CategoryModel] = []
    private(set) var searchText: String = ""
    var selectedIndex: Int = 0
    var isEditingActive: Bool = false
    
    var reloadData: ((Bool) -> Void)?
    
    // MARK: - Change the editing status--
    
    func toggleEditingStatus(_ isEnabled: Bool) {
        isEditingActive = isEnabled
        reloadData?(true)
    }
    // MARK: - update the model data according to searched text--
    func updateModel(with text: String?) {
        searchText = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        reloadData?(true)
    }
    // MARK: - Get selected index category title --
    func getSelectedCategoryName() -> String {
        guard categories.indices.contains(selectedIndex) else { return "" }
        return categories[selectedIndex].title ?? ""
    }
    // MARK: - Get categories--
    func getCategories() -> [CategoryModel] {
        return categories
    }
    // MARK: - Get filtered data --
    func getFilteredData() -> [ItemListModel] {
        return filteredItems
    }
    // MARK: - Get all sections--
    func getSections() -> [Section] {
        return Section.allCases
    }
    // MARK: - Get section index--
    func getTopSectionIndex() -> Int {
        return Section.top.rawValue
    }
    // MARK: - Get number of row in sections--
    func numberOfRowsInSection(section: Int) -> Int {
        if section == getTopSectionIndex() {
            return isEditingActive ? 0 : 1
        }
        return filteredItems.count
    }
    // MARK: - Filter top three character--
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
    
    // MARK: - Data Fetch
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
    
    // MARK: - Computed
    private var filteredItems: [ItemListModel] {
        guard categories.indices.contains(selectedIndex) else { return [] }
        
        let currentItems = categories[selectedIndex].items ?? []
        
        guard !searchText.isEmpty else { return currentItems }
        
        return currentItems.filter {
            $0.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
}

