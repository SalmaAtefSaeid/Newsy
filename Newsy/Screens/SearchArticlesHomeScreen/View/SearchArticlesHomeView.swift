//
//  SearchArticlesHomeView.swift
//  Newsy
//
//  Created by Salma Atef on 10/12/2021.
//

import SwiftUI

struct SearchArticlesHomeView: View {
    
    @StateObject var viewModel = SearchArticlesHomeViewModel()
    @State private var searchText = ""
    @State private var searching = false
    @State private var shouldPopToRootView = false
    private var timer = Timer.publish(every: 30 * 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if shouldPopToRootView {
            OnboardingView()
        } else {
            ZStack {
                Group {
                    if viewModel.networkError != nil {
                        RetryView(text: viewModel.networkError?.localizedDescription ?? "error", action: {
                            viewModel.getArticles(updateTheArticles: true)
                        })
                    } else if viewModel.noArticleFound == true {
                        NoArticleView()
                    } else if viewModel.articles.isEmpty {
                        ProgressView("Downloading...")
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        VStack(alignment: .leading) {
                            SearchBarView(searchText: $searchText)
                                .padding([.top, .bottom], 16)
                            ArticlesListView(articles: $viewModel.articles, searchText: $searchText)
                        }
                        
                    }
                }
                .navigationTitle(viewModel.category ?? "")
                .navigationBarHidden(viewModel.category == nil)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.deleteArticles()
                        shouldPopToRootView = true
                    }) {
                        Image("arrows-circle")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 35, height: 35, alignment: .trailing)
                }
            }
            .accentColor(Color.black)
            .onReceive(timer) { _ in
                viewModel.getArticles(updateTheArticles: true)
            }
            .task {
                viewModel.getArticles(updateTheArticles: false)
            }
        }
    }
}

#Preview {
    SearchArticlesHomeView()
}
