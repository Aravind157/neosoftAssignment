//
//  CategoryRowView.swift
//  PizzaMenuSwiftUI
//
//  Created by aravind  yadav on 10/04/25.
//

import SwiftUI

struct CategoryRowView: View {
    var urlString: String?
    
    var body: some View {
        VStack {
            if let urlString = urlString, let imageURL = URL(string: urlString) {
                AsyncImage(url: imageURL, scale: 2) { phase in
                    switch phase {
                    case .empty:
                        placeholderImage
                    case .success(let image):
                        imageView(image)
                    case .failure:
                        placeholderImage
                    @unknown default:
                        placeholderImage
                    }
                }
            } else {
                placeholderImage
            }
        }
    }
    
    private var placeholderImage: some View {
        Image(.placeholder) // Make sure "placeholder" exists in Assets
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .cornerRadius(20)
            .clipped()
            .padding(20)
    }
    
    private func imageView(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .cornerRadius(20)
            .clipped()
            .padding(20)
    }
}

