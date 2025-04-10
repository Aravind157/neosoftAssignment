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

    // MARK: - Public API
    
    func toggleEditingStatus(_ isEnabled: Bool) {
        isEditingActive = isEnabled
        reloadData?(true)
    }

    func updateModel(with text: String?) {
        searchText = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        reloadData?(true)
    }

    func getSelectedCategoryName() -> String {
        guard categories.indices.contains(selectedIndex) else { return "" }
        return categories[selectedIndex].title ?? ""
    }

    func getCategories() -> [CategoryModel] {
        return categories
    }

    func getFilteredData() -> [ItemListModel] {
        return filteredItems
    }

    func getSections() -> [Section] {
        return Section.allCases
    }

    func getTopSectionIndex() -> Int {
        return Section.top.rawValue
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if section == getTopSectionIndex() {
            return isEditingActive ? 0 : 1
        }
        return filteredItems.count
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

    // MARK: - Data Fetch
    func getData() {
        guard let rawData = FileManagerHelper.getFileContent(with: FileName.pizzaJson, and: .json),
              let decoded: BaseModel = JsonParser.decodeJson(from: rawData, in: BaseModel.self) else {
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

