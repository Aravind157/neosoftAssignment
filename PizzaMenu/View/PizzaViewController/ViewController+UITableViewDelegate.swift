//
//  File.swift
//  PizzaMenu
//
// Created by aravind  yadav on 09/04/25.
//

import UIKit

    // MARK: - UITableViewDelegate
    extension ViewController: UITableViewDelegate {

        func numberOfSections(in tableView: UITableView) -> Int {
            return viewModel.getSections().count
        }

        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let sectionType = viewModel.getSections()
            switch sectionType[section] {
            case .top:
                return nil
            case .list:
                let searchView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifier.searchView) as! SearchView
                searchView.searchBar.delegate = self
                searchView.searchBar.text = viewModel.searchText
                searchView.isEditingActive = viewModel.isEditingActive
                searchView.placeholder = viewModel.getSelectedCategoryName()
                return searchView
            }
        }

        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            let sectionType = viewModel.getSections()
            switch sectionType[section] {
            case .top:
                return 0
            case .list:
                return 60
            }
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == viewModel.getTopSectionIndex() {
                return UIScreen.main.bounds.size.height * 0.3
            }
            return UITableView.automaticDimension
        }
    }


    
