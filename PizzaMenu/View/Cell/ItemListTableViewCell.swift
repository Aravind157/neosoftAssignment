//
//  ItemListTableViewCell.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemDescription: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var parentView: UIView!{
        didSet{
            parentView.layer.cornerRadius = 10
        }
    }
    
    var item: ItemListModel?{
        didSet{
            setData()
        }
    }
    
    func setData(){
        lblItemName.text = item?.name ?? ""
        lblItemDescription.text = item?.description ?? ""
        if let urlString = item?.image, let url = URL(string:urlString){
            imgItem.setImage(from: url, placeholder: UIImage(named: ImageConstant.placeholder_image))
        }else{
            imgItem.image = UIImage(named: ImageConstant.placeholder_image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgItem.layer.cornerRadius =  10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
