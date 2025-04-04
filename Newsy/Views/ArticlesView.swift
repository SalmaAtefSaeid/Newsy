//
//  ArticlesView.swift
//  Newsy
//
//  Created by Salma Atef on 03/04/2025.
//

import SwiftUI

struct ArticlesView : View {
    let article: Article
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RemoteWebImage(urlString: article.urlToImage ?? "")
            .frame(width: UIScreen.main.bounds.width - 70, height: UIScreen.main.bounds.width / 4 * 3, alignment: .center)
            .scaledToFit()
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.3)
            
            VStack {
                Text(article.source?.name ?? "")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .lineLimit(nil)
                    .padding([.leading, .trailing])
                    .frame(width: UIScreen.main.bounds.width - 70, alignment: .bottomLeading)
                
                Text(article.title ?? "")
                    .foregroundColor(.white)
                    .font(.headline)
                    .lineLimit(nil)
                    .padding([.leading, .bottom, .trailing])
                    .frame(width: UIScreen.main.bounds.width - 70, alignment: .bottomLeading)
            }
        }
        .cornerRadius(8)
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 8)
        .shadow(color: .black, radius: 8, x: 0, y: 0)
        .frame(width:  UIScreen.main.bounds.width - 65, height: UIScreen.main.bounds.width / 4 * 3, alignment: .center)
    }
}

#Preview {
    ArticlesView(article: .previewData[1])
}
