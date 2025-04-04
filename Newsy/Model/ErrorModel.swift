//
//  ErrorModel.swift
//  Newsy
//
//  Created by Salma Atef on 04/04/2025.
//

import Foundation

struct ErrorModel: Codable, Error {
    var code: Int
    var message: String?
    
    var localizedDescription: String {
        return "Error \(code): \(message ?? "")"
    }
}
