//
//  ArticlesListHomeViewModel.swift
//  Newsy
//
//  Created by Salma Atef on 03/04/2025.
//

import Foundation

final class ArticlesListHomeViewModel: ObservableObject {
    
    private let networkManager = NetworkManager()
    @Published var articles: [Article] = []
    @Published var networkError: NSError?
    @Published var noArticleFound: Bool = false
    
    init() {
        getArticles()
    }
    
    func getArticles() {
        networkError = nil
        noArticleFound = false
        
        let parameters = [
            "category": Category.general.rawValue,
            "apiKey": NetworkConstants.apiKey
        ]
        
        networkManager.sendHTTPRequest(urlString: NetworkConstants.requestToGetTopHeadlines, httpMethod: HTTPMethodType.get.rawValue, parameters: parameters, successHandler: { [weak self] (articleAPIResponse: ArticleAPIResponse) in
            guard let self = self else { return }
            
            if let articles = articleAPIResponse.articles, articleAPIResponse.status == "ok" {
                if articles.isEmpty {
                    self.noArticleFound = true
                } else {
                    self.articles = articles
                    articles.forEach { $0.store() }
                }
            } else {
                let error = NSError(domain: "News API", code: Int(articleAPIResponse.code ?? "-1") ?? -1, userInfo: [NSLocalizedDescriptionKey: articleAPIResponse.status as Any])
                self.networkError = error
            }
        }, failureHandler: { [weak self] (error) in
            print("Network error: \(error.localizedDescription)")
            self?.networkError = error as NSError
        })
    }
}
