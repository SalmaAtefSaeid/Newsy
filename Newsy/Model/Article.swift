//
//  Article.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import Foundation

struct Article: Codable, Hashable, Identifiable {
    
    let id = UUID()
    
    let source: ArticleSource?
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: String?
    
    enum CodingKeys: CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
    }
    
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

extension Article {
    
    static var previewData: [Article] {
        guard let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: previewDataURL)
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            
            
            let apiResponse = try jsonDecoder.decode(ArticleAPIResponse.self, from: data)
            return apiResponse.articles ?? []
        } catch {
            print("error in decode json \(error)")
            return []
        }
        
    }
    
}
