//
//  SearchArticlesHomeViewModel.swift
//  Newsy
//
//  Created by Salma Atef on 11/12/2021.
//

import Foundation

final class SearchArticlesHomeViewModel: ObservableObject {
    
    @Published var articles = [Article]()
    @Published var networkError: NSError?
    @Published var noArticleFound = false
    
    var category: String?
    
    @MainActor
    func getArticles(updateTheArticles: Bool) {
        networkError = nil
        noArticleFound = false
        
        let articleRequiredInfo = ArticleHelper.loadArticleRequiredInfo()
        self.category = articleRequiredInfo.category
        
        let articlesList = fetchArticles()
        
        if articlesList.isEmpty || updateTheArticles {
            let parameters = [
                "category": articleRequiredInfo.category,
                "country": articleRequiredInfo.country,
                "apiKey": NetworkConstants.apiKey
            ]
            Task {
                do {
                    let articleAPIResponse: ArticleAPIResponse = try await NetworkManager.shared.sendHTTPRequest(urlString: NetworkConstants.requestToGetTopHeadlines, httpMethod: .get, parameters: parameters)
                    if let articles = articleAPIResponse.articles, articleAPIResponse.status == "ok" {
                        if articles.isEmpty {
                            self.noArticleFound = true
                        }
                        self.articles = articles
                        articles.forEach { $0.store() }
                    } else {
                        // Handle failure
                        let error = NSError(domain: "News API", code: Int(articleAPIResponse.code ?? "-1") ?? -1, userInfo: [NSLocalizedDescriptionKey: articleAPIResponse.status as Any])
                        self.networkError = error
                    }
                } catch {
                    print(error.localizedDescription)
                    self.networkError = error as NSError
                }
            }
            
        } else {
            self.articles = articlesList
        }
    }
    
    func fetchArticles() -> [Article] {
        return ArticleHelper.fetchArticles()
    }
    
    func deleteArticles() {
        ArticleHelper.deleteAllData()
        ViewRouter.sharedInstance().saveData(didLaunchBefore: false)
    }
}
