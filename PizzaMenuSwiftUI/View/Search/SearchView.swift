//
//  SearchView.swift
//  PizzaMenuSwiftUI
//
//  Created by aravind  yadav on 10/04/25.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    var placeholder: String
    @ObservedObject var viewModel: ItemsViewModel
    @FocusState var isTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            HStack {
                //  Search Icon
                Image(systemName: ImageConstant.search)
                    .foregroundColor(.gray)
                
                // Search TextField
                TextField(placeholder, text: $text)
                    .focused($isTextFieldFocused)
                    .onTapGesture {
                        viewModel.isEditing = true
                    }
                
                //  Clear Button
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: ImageConstant.cancel)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            // Cancel Button
            if viewModel.isEditing {
                Button(StringConstants.CANCEL) {
                    text = ""
                    viewModel.isEditing = false
                    isTextFieldFocused = false
                    hideKeyboard()
                }
                .foregroundColor(.black)
                .transition(.move(edge: .trailing))
                .animation(.easeInOut, value: viewModel.isEditing)
            }
        }
        .padding(.horizontal)
    }
    
    //  Keyboard Dismiss Helper
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


