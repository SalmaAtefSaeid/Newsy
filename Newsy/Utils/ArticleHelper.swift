//
//  ArticleHelper.swift
//  Newsy
//
//  Created by Salma Atef on 11/12/2021.
//

import Foundation
import CoreData

class ArticleHelper {
    
    static func mapFromArticleDB(articleDB: ArticleDB) ->  Article {
        let article = Article(source: ArticleSource(id: "", name: articleDB.articleSource), author: articleDB.author, title: articleDB.title, description: articleDB.desc, url: URL(string: articleDB.url ?? ""), urlToImage: articleDB.urlToImage)
        return article
    }
    
    static func saveArticleRequiredInfo(category: Category, country: Country) {
        let persistence = PersistenceController.shared
        let context = persistence.container.viewContext
        
        // Create or fetch the category entity
        let categoryDB = CategoryDB(context: context)
        categoryDB.category = category.rawValue
        
        // Create or fetch the country entity
        let countryDB = CountryDB(context: context)
        countryDB.countryCode = country.rawValue
        
        // Save the context
        do {
            try context.save()
        } catch {
            print("Failed to save article required info: \(error.localizedDescription)")
        }
    }

    static func loadArticleRequiredInfo() -> (category: String, country: String) {
        let persistence = PersistenceController.shared
        let context = persistence.container.viewContext
        
        let categoryFetchRequest: NSFetchRequest<CategoryDB> = CategoryDB.fetchRequest()
        let countryFetchRequest: NSFetchRequest<CountryDB> = CountryDB.fetchRequest()

        do {
            let categoryDB = try context.fetch(categoryFetchRequest)
            let countryDB = try context.fetch(countryFetchRequest)
            
            let category = categoryDB.first?.category ?? ""
            let countryCode = countryDB.first?.countryCode ?? ""
            
            return (category, countryCode)
        } catch {
            print("Failed to load article required info: \(error.localizedDescription)")
            return ("", "")
        }
    }
    
    static func fetchArticles() -> [Article] {
        let context = PersistenceController.shared.container.viewContext
        let articleFetchRequest: NSFetchRequest<ArticleDB> = ArticleDB.fetchRequest()
        
        do {
            // Fetch ArticleDB entries
            let articleDBs = try context.fetch(articleFetchRequest)
            
            // Map fetched ArticleDB objects to Article models
            let articles = articleDBs.map { ArticleHelper.mapFromArticleDB(articleDB: $0) }
            return articles
        } catch {
            print("Failed to fetch articles: \(error.localizedDescription)")
            return [] // Return an empty array on error
        }
    }

    static func deleteAllData() {
        let context = PersistenceController.shared.container.viewContext
        
        // Define fetch requests for each entity
        let categoryFetchRequest: NSFetchRequest<CategoryDB> = CategoryDB.fetchRequest()
        let countryFetchRequest: NSFetchRequest<CountryDB> = CountryDB.fetchRequest()
        let articleFetchRequest: NSFetchRequest<ArticleDB> = ArticleDB.fetchRequest()
        
        do {
            // Fetch and delete all CategoryDB entries
            let categories = try context.fetch(categoryFetchRequest)
            for category in categories {
                context.delete(category)
            }
            
            // Fetch and delete all CountryDB entries
            let countries = try context.fetch(countryFetchRequest)
            for country in countries {
                context.delete(country)
            }
            
            // Fetch and delete all ArticleDB entries
            let articles = try context.fetch(articleFetchRequest)
            for article in articles {
                context.delete(article)
            }
            
            // Save context after deletions
            try context.save()
        } catch {
            print("Failed to delete data: \(error.localizedDescription)")
        }
    }
}
