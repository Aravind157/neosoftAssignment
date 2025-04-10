//
//  SearchView.swift
//  PizzaMenuSwiftUI
//
//  Created by aravind  yadav on 10/04/25.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var text : String
    var placeholder: String
    @ObservedObject var viewModel: ItemsViewModel
    @FocusState var isTextFieldFocused: Bool
    
   
    var body: some View {
        HStack{
            TextField("\(StringConstants.SEARCH) \(placeholder ) .....",text: $text)
                .focused($isTextFieldFocused)
                .keyboardType(.asciiCapable)
            
                .submitLabel(.search)
                .padding(7)
                .padding(.horizontal,25)
                .background(Color(ColorConstants.lightGray), ignoresSafeAreaEdges: .all)
//                .background(ColorConstants.lightGray)
                .cornerRadius(8)
                .overlay (
                    HStack{
                        Image(systemName: ImageConstant.placeholder_image)
                            .foregroundColor(.gray)
                            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                            .padding(.leading,8)
                    }
                )
                .padding(.horizontal,10)
                .onTapGesture {
                    DispatchQueue.main.async {
                        viewModel.isEditing = true
                        isTextFieldFocused = true
                        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            if viewModel.isEditing{
                Button {
                    viewModel.isEditing = false
                    self.text = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                } label: {
                    withAnimation(.easeIn) {
                        Text(StringConstants.CANCEL)
                            .tint(.black)
                    }
                    
                }
                .padding(.trailing,10)
                .transition(.move(edge: .trailing))
            }
            
        }
       
    }
    
}
