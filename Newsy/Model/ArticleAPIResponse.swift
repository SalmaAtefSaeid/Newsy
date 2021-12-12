//
//  ArticleAPIResponse.swift
//  Newsy
//
//  Created by Salma Atef on 10/12/2021.
//

import Foundation

struct ArticleAPIResponse: Codable {
    
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    let code: String?
    let message: String?
    
}
