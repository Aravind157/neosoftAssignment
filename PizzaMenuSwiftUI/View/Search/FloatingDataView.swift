//
//  FloatingDataView.swift
//  PizzaMenuSwiftUI
//
//  Created by aravind  yadav on 10/04/25.
//

import SwiftUI
struct FloatingDataView: View {
    var dict: [[Character: Int]]
    var categoryName: String
    var productCount: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(categoryName) (\(productCount) items)")
                        .bold()
                    
                    ForEach(dict, id: \.self) { item in
                        if let (key, value) = item.first {
                            Text("\(String(key)) = \(value)")
                                .fontWeight(.medium)
                        }
                    }
                }
                Spacer()
            }
            .padding(20)
            Spacer()
        }
    }
}

