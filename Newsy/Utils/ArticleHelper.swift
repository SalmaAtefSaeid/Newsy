//
//  ArticleHelper.swift
//  Newsy
//
//  Created by Salma Atef on 11/12/2021.
//

import Foundation

class ArticleHelper {
    
    static func mapFromArticleDB(articleDB: ArticleDB) ->  Article {
        let article = Article(source: ArticleSource(id: "", name: articleDB.articleSource), author: articleDB.author, title: articleDB.title, description: articleDB.desc, url: URL(string: articleDB.url ?? ""), urlToImage: articleDB.urlToImage)
        return article
    }
    
    static func saveArticleRequiredInfo(category: Category, country: Country) {
        let persistence = PersistenceController.shared
        guard let categoryDB = persistence.add(CategoryDB.self) else {return}
        categoryDB.category = category.rawValue
        guard let countryDB = persistence.add(CountryDB.self) else {return}
        countryDB.countryCode = country.rawValue
        persistence.save()
    }
    
    static func loadArticleRequiredInfo() -> (category: String, country: String) {
        let persistence = PersistenceController.shared
        let categoryDB = persistence.fetch(CategoryDB.self)
        let countryDB = persistence.fetch(CountryDB.self)
        return (categoryDB.first?.category ?? "", countryDB.first?.countryCode ?? "")
    }
}
