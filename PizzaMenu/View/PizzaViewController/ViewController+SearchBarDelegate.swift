//
//  File.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import UIKit

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.toggleEditingStatus(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            searchBar.showsCancelButton = true
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //MARK: - Space at first index is restricted
        if text == " " && range.location == 0 {
            return false
        }
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateModel(with: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        viewModel.updateModel(with: searchBar.text)
        viewModel.toggleEditingStatus(false)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //MARK: - Hide cancel on editing end
        viewModel.updateModel(with: searchBar.text)
        if !viewModel.isEditingActive {
            searchBar.showsCancelButton = false
        }
    }
    
}
