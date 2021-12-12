//
//  HomeViewModel.swift
//  Newsy
//
//  Created by Salma Atef on 11/12/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    var objectWillChange = PassthroughSubject<Void, Never>()
    private let networkManager = NetworkManager()
    var category: String?
    
    init() {
        getArticles(updateTheArticles: false)
    }
    
    var articles = [Article]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    var networkError: NSError? {
        didSet {
            objectWillChange.send()
        }
    }
    
    var noArticleFound = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    func getArticles(updateTheArticles: Bool) {
        networkError = nil
        noArticleFound = false
        let articleRequiredInfo = ArticleHelper.loadArticleRequiredInfo()
        self.category = articleRequiredInfo.category
        let articlesList = fetchArticles()
        if articlesList.isEmpty || updateTheArticles {
            let parameters = ["category": articleRequiredInfo.category, "country": articleRequiredInfo.country, "apiKey": NetworkConstants.apiKey]
            networkManager.sendHTTPRequest(urlString: NetworkConstants.requestToGetTopHeadlines, httpMethod: HTTPMethodType.get.rawValue, parameters: parameters, successHandler: { [weak self] (articleAPIResponse: ArticleAPIResponse) in
                if let articles = articleAPIResponse.articles, articleAPIResponse.status == "ok" {
                    if articles.count == 0 {
                        self?.noArticleFound = true
                    }
                    self?.articles = articles
                    articles.forEach { $0.store() }
                } else {
                    // handle failure
                    let error = NSError(domain: "News API", code: Int(articleAPIResponse.code ?? "-1") ?? -1, userInfo: [NSLocalizedDescriptionKey: articleAPIResponse.status as Any])
                    self?.networkError = error
                }
            }, failureHandler: { (error) in
                print(error.localizedDescription)
                self.networkError = error as NSError
            })
        } else {
            self.articles = articlesList
        }
    }
    
    func fetchArticles() -> [Article] {
        let persistence = PersistenceController.shared
        let articlesDB = persistence.fetch(ArticleDB.self)
        var articles = [Article]()
        for article in articlesDB {
            articles.append(ArticleHelper.mapFromArticleDB(articleDB: article))
        }
        return articles
    }
}
