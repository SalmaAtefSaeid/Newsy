//
//  ArticlesListHomeView.swift
//  Newsy
//
//  Created by Salma Atef on 03/04/2025.
//

import SwiftUI

struct ArticlesListHomeView: View {
    
    @StateObject var viewModel: ArticlesListHomeViewModel = ArticlesListHomeViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.networkError != nil {
                RetryView(text: viewModel.networkError?.localizedDescription ?? "error", action: {
                    viewModel.getArticles()
                })
            } else if viewModel.noArticleFound == true {
                NoArticleView()
            } else if viewModel.articles.isEmpty {
                ProgressView("Downloading...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                VStack(alignment: .leading) {
                    ArticlesListView(articles: $viewModel.articles, searchText: .constant(""))
                }
            }
        }
    }
    
}

#Preview {
    ArticlesListHomeView()
}
