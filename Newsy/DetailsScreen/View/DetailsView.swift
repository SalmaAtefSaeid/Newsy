//
//  DetailsView.swift
//  Newsy
//
//  Created by Salma Atef on 11/12/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    
    let article : Article
    
    var body: some View {
        ScrollView {
            
            let placeholder = UIImage(named: "no-image")!
            WebImage(url: URL(string: article.urlToImage ?? "")).placeholder(Image(uiImage: placeholder))
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 400, alignment: .center)
                .scaledToFit()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(article.title ?? "")
                        .font(.title)
                    if let articleUrl = article.url {
                        Spacer()
                        Link(destination: articleUrl) {
                            Image(systemName: "link")
                                .font(.largeTitle)
                        }
                    }
                }
                
                HStack {
                    Text(article.source?.name ?? "")
                    Spacer()
                    Text(article.author ?? "")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                Text(article.description ?? "")
            }
            .padding()
        }
        .navigationTitle(article.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .accentColor( .black)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(article: Article(source: ArticleSource(id: "", name: ""), author: "", title: "", description: "", url: URL(string: ""), urlToImage: ""))
    }
}
