//
//  DetailsView.swift
//  Newsy
//
//  Created by Salma Atef on 11/12/2021.
//

import SwiftUI

struct DetailsView: View {
    
    let article : Article
    
    var body: some View {
        ScrollView {
            RemoteWebImage(urlString: article.urlToImage ?? "")
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 400, alignment: .center)
            
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
        .ignoresSafeArea(edges: .top)
        .navigationTitle(article.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(article: .previewData[1])
    }
}
