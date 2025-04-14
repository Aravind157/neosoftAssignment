//
//  CategoryCollectionViewCell.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var category : CategoryModel? {
        didSet{
            if let image = category?.thumbnail,let url = URL(string: image){
                categoryImageView.setImage(from: url, placeholder: UIImage(named: ImageConstant.placeholder_image))
            }else{
                categoryImageView.image = UIImage(named: ImageConstant.placeholder_image)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImageView.layer.cornerRadius = 10
    }
    
}
