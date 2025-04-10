//
//  ViewController.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import UIKit


class SearchView : UITableViewHeaderFooterView{
  
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.searchTextField.backgroundColor = .clear
        }
    }

    
    var isEditingActive: Bool = false {
        didSet {
            searchBar.searchTextField.text = isEditingActive ? searchBar.searchTextField.text : ""
        }
    }
    
    var placeholder: String? = "" {
        didSet {
            searchBar.searchTextField.placeholder = "\(StringConstants.SEARCH) \(placeholder ?? "") ......"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
