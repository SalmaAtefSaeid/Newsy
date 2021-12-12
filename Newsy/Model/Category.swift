//
//  Category.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import Foundation

enum Category: String, CaseIterable {
    
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var description: String {
        switch self {
        case .general:
            return "Top Headlines"
        default:
            return rawValue.capitalized
        }
    }
}
