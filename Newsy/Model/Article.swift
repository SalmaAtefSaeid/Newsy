//
//  Article.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import Foundation

struct Article: Codable, Hashable {
    
    let source: ArticleSource?
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: String?
    
    func store() {
        let persistence = PersistenceController.shared
        guard let article = persistence.add(ArticleDB.self) else {return}
        article.articleSource = source?.name
        article.author = author
        article.title = title
        article.desc = description
        article.url = url?.absoluteString
        article.urlToImage = urlToImage
        persistence.save()
    }
}

struct ArticleSource: Codable, Hashable {
    let id: String?
    let name: String?
}
