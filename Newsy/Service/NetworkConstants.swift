//
//  NetworkConstants.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import Foundation

class NetworkConstants {
    
    private static let baseURL =  "https://newsapi.org/v2"
    static let requestToGetEverything = baseURL + "/everything"
    static let requestToGetTopHeadlines = baseURL + "/top-headlines"
    static let requestToGetSources = requestToGetTopHeadlines + "/sources"
    static let apiKey = "dbf93b8234a444c3808e44ce0b2cf25d"
    
}
