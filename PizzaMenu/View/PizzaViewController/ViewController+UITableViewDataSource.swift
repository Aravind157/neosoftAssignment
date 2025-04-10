//
//  ViewController+UITableViewDataSource.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import UIKit

// MARK: - UITableViewDataSource
    extension ViewController: UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfRowsInSection(section: section)
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let sections = viewModel.getSections()
            switch sections[indexPath.section] {
            case .top:
                guard let carouselCell = tableView.dequeueReusableCell(withIdentifier: Identifier.CategoryTableViewCell) as? CategoryTableViewCell else {
                    return UITableViewCell()
                }
                carouselCell.currentIndex = viewModel.selectedIndex
                carouselCell.categories = viewModel.getCategories()
                carouselCell.updateBottomView = { [weak self] currentIndex in
                    guard let self = self else { return }
                    self.viewModel.selectedIndex = currentIndex
                    self.reloadData()
                }
                return carouselCell

            case .list:
                guard let itemCell = tableView.dequeueReusableCell(withIdentifier: Identifier.ItemListTableViewCell) as? ItemListTableViewCell else {
                    return UITableViewCell()
                }
                let item = viewModel.getFilteredData()[indexPath.row]
                itemCell.item = item
                return itemCell
            }
        }
    }
