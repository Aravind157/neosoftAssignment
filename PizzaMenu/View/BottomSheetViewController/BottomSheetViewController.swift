//
//  BottomSheetViewController.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var lblcategoryNameAndCount: UILabel!
    @IBOutlet weak var lblfirstLetterCount: UILabel!
    @IBOutlet weak var lblsecondLetterCount: UILabel!
    @IBOutlet weak var lblthirdLetterCount: UILabel!

    var dict: [[Character: Int]] = []
    var categoryName: String?
    var itemsCount: Int?
    
    // Transparent background view
    private lazy var backgroundTapView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Setup Method
    private func setupUI() {
        lblcategoryNameAndCount.text = "\(categoryName ?? "") = (\(itemsCount ?? 0) \(StringConstants.ITEMS))"
        
        for (index, dic) in dict.enumerated() {
            guard let key = dic.keys.first, let value = dic.values.first else { continue }
            
            switch index {
            case 0:
                lblfirstLetterCount.text = "\(key) = \(value)"
            case 1:
                lblsecondLetterCount.text = "\(key) = \(value)"
            case 2:
                lblthirdLetterCount.text = "\(key) = \(value)"
            default:
                break
            }
        }
        
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
    }

    @IBAction func btnCloseTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        backgroundTapView.removeFromSuperview()
    }
}
