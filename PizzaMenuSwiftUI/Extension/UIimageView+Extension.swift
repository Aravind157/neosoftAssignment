//
//  UIimageView+Extension.swift
//  PizzaMenuSwiftUI
//
//  Created by aravind  yadav on 14/04/25.
//

import Foundation
import UIKit
extension UIImageView {
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func setImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        getData(from: url) { [weak self] data, _, error in
            guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.image = placeholder
                }
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
