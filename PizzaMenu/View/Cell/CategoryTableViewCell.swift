//
//  CategoryTableViewCell.swift
//  PizzaMenu
//
//  Created by aravind  yadav on 09/04/25.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var updateBottomView: ((Int) -> ())?
    
    var categories : [CategoryModel]?{
        didSet{
            pageControl.numberOfPages = categories?.count ?? 0
            pageControl.currentPage = currentIndex
            pageControl.currentPageIndicatorTintColor =  ColorConstants.ceruleanBlue
            pageControl.tintColor = ColorConstants.muteSage
        }
    }
    
    var currentIndex : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: Identifier.categoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.categoryCollectionViewCell)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CategoryTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.categoryCollectionViewCell, for: indexPath) as! CategoryCollectionViewCell
        cell.category = categories?[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.currentIndex = pageControl.currentPage
        updateBottomView?(currentIndex)
    }
    
}

