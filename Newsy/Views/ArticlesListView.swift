//
//  ArticlesListView.swift
//  Newsy
//
//  Created by Salma Atef on 03/04/2025.
//

import SwiftUI

struct ArticlesListView: View {
    
    @Binding var articles: [Article]
    @Binding var searchText: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(articles.filter{$0.title?.lowercased().contains(searchText.lowercased()) ?? false || searchText == ""}) { article in
                    NavigationLink(destination:
                            DetailsView(article: article)
                            .navigationBarTitle(Text(article.title ?? ""), displayMode: .large)
                    ) {
                        ArticlesView(article: article)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .padding(.leading)
                    }
                    .listRowInsets(EdgeInsets())
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color.clear)
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
            }
        }
        .accentColor(.black)
    }
}

#Preview {
    ArticlesListView(articles: .constant(Article.previewData), searchText: .constant(""))
}
