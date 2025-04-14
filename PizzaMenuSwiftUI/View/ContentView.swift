//
//  ContentView.swift
//  PizzaMenuSwiftUI
//
//  Created by aravind  yadav on 10/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ItemsViewModel()
    @State private var floatingViewExpanded = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView {
                        LazyVStack(pinnedViews: .sectionHeaders) {
                            if !viewModel.isEditing {
                                Section {
                                    VStack(spacing: 10) {
                                        TabView(selection: $viewModel.selectedIndex) {
                                            ForEach(viewModel.categories.indices, id: \.self) { index in
                                                CategoryRowView(urlString: viewModel.categories[index].thumbnail ?? "")
                                                    .tag(index)
                                            }
                                        }
                                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                        .frame(height: 200)
                                        
                                        HStack {
                                            Spacer()
                                            ForEach(viewModel.categories.indices, id: \.self) { index in
                                                Capsule()
                                                    .fill(viewModel.selectedIndex == index ? Color.blue : Color.gray)
                                                    .frame(width: 8, height: 8)
                                                    .onTapGesture {
                                                        withAnimation {
                                                            viewModel.selectedIndex = index
                                                        }
                                                    }
                                            }
                                            Spacer()
                                        }
                                    }
                                    
                                } header: {
                                    EmptyView()
                                }
                            }
                            
                            Section {
                                ForEach(viewModel.filteredItems) { movie in
                                    ItemRowView(filteredMovie: movie)
                                }
                            } header: {
                                SearchView(
                                    text: $viewModel.searchText,
                                    placeholder: viewModel.categories.isEmpty ? "" : viewModel.categories[viewModel.selectedIndex].title ?? "",
                                    viewModel: viewModel,
                                    isTextFieldFocused: _isTextFieldFocused
                                )
                                .padding([.top, .bottom], 10)
                            }
                            .background(Color.white)
                        }
                    }
                }
                
                // Floating Button
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            floatingViewExpanded.toggle()
                        } label: {
                            Image(ImageConstant.ellipsis_vertical)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                        }
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding(20)
                    }
                }
            }
            .clipped()
            .sheet(isPresented: $floatingViewExpanded) {
                if !viewModel.categories.isEmpty {
                    FloatingDataView(
                        dict: viewModel.topThreeCharacters,
                        categoryName: viewModel.categories[viewModel.selectedIndex].title ?? "",
                        productCount: viewModel.filteredItems.count
                    )
                    .presentationDetents([.height(250), .medium])
                }
            }
        }
        .onChange(of: viewModel.searchText,initial: false) { _,_  in
            DispatchQueue.main.async {
                isTextFieldFocused = viewModel.isEditing
            }
        }
        .onAppear {
            viewModel.getData()
        }
    }
}

#Preview {
    ContentView()
}
