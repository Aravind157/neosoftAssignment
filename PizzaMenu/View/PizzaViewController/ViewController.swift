//
//  ViewController.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingButton: UIButton!
    
    var viewModel : ItemsViewModel = ItemsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI(){
        //MARK: - Register completion to reload tableview
        viewModel.reloadData = {[weak self] animation in
            self?.reloadData(with: animation)
        }
        
        floatingButton.layer.cornerRadius = floatingButton.frame.size.height / 2
        registerCell()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        viewModel.getData()
        reloadData()
    }
    
    private func registerCell(){
        tableView.register(UINib(nibName:Identifier.categoryTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.categoryTableViewCell)
        tableView.register(UINib(nibName: Identifier.searchView, bundle: nil), forHeaderFooterViewReuseIdentifier:Identifier.searchView)
        tableView.register(UINib(nibName: Identifier.itemListTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.itemListTableViewCell)
    }
    
     func reloadData(with animation: Bool  = false){
        if animation {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.tableView.reloadData()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController {
    
    @IBAction func floatingButtonAction(_ sender: UIButton){
        
        let viewControllerToPresent = BottomSheetViewController()
        viewControllerToPresent.categoryName = viewModel.getSelectedCategoryName()
        viewControllerToPresent.itemsCount = viewModel.getFilteredData().count
        viewControllerToPresent.dict = viewModel.topThreeCharacters
        
        if let sheet = viewControllerToPresent.sheetPresentationController {
            if #available(iOS 16.0, *) {
                // Define a custom detent
                let fraction = UISheetPresentationController.Detent.custom { context in
                    // Return a constant value for the height (you can adjust this as needed)
                    return 250.0
                }
                
                // Set the detents
                sheet.detents = [fraction, .medium()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            } else {
                // Handle fallback for earlier versions of iOS if needed
                sheet.detents = [.medium()]
                sheet.largestUndimmedDetentIdentifier = .medium
            }
        }
        
        // Present the view controller
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
}


