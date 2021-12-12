//
//  StringExt.swift
//  Newsy
//
//  Created by Salma Atef on 10/12/2021.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
