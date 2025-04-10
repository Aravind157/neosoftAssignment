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
    
    // Add a transparent background view for tapping
    private lazy var backgroundTapView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    @objc private func handleBackgroundTap() {
        dismiss(animated: true)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if gesture.state == .changed {
            // Only allow downward dragging
            if translation.y > 0 {
                view.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        } else if gesture.state == .ended {
            if translation.y > view.bounds.height/3 || velocity.y > 1500 {
                dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = .identity
                }
            }
        }
    }
    
    func setUpUI() {
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
        
        // Style the sheet
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        backgroundTapView.removeFromSuperview()
    }
}
