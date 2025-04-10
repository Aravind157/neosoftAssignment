//
//  CategoryRowView.swift
//  PizzaMenuSwiftUI
//
//  Created by aravind  yadav on 10/04/25.
//

import SwiftUI

struct CategoryRowView: View {
    var url: String?

    var body: some View {
        VStack {
            if let urlSting = url, let extractedURL = URL(string: urlSting) {
                AsyncImage(url: extractedURL, scale: 2) { phase in
                    switch phase {
                    case .empty:
                        placeholderImage
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .cornerRadius(20)
                            .clipped()
                            .padding(20)
                    case .failure(_):
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
        Image(.placeholder)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .cornerRadius(20)
            .clipped()
            .padding(20)
    }
}

