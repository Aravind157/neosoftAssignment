//
//  ItemRowView.swift
//  PizzaMenuSwiftUI
//
//  Created by aravind  yadav on 10/04/25.
//

import SwiftUI

struct ItemRowView: View {
    
    var filteredMovie : ItemListModel
    
    var body: some View {
        VStack(alignment: .trailing){
            HStack(spacing: 2){
                if let urlSting = filteredMovie.image , let url = URL(string: urlSting){
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            placeholderImageView
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60,height: 60)
                                .cornerRadius(10)
                                .clipped()
                                .padding([.leading,.trailing],20)
                                .padding([.top,.bottom],10)
                        case .failure(_):
                            placeholderImageView
                        @unknown default:
                            placeholderImageView
                        }
                    }
                }else{
                    placeholderImageView
                }
                
                VStack(alignment: .leading){
                    Text(filteredMovie.name ?? "")
                        .fontWeight(.medium)
                    Text(filteredMovie.description ?? "")
                        .font(.subheadline)
                }
                Spacer()
            }
            .background(Color(ColorConstants.lightAqua), ignoresSafeAreaEdges: .all)
            .cornerRadius(10)
            .padding([.leading,.trailing],10)
        }
    }
    var placeholderImageView: some View {
        Image(.placeholder)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60,height: 60)
            .cornerRadius(10)
            .clipped()
            .padding([.leading,.trailing],20)
            .padding([.top,.bottom],10)
    }
}
