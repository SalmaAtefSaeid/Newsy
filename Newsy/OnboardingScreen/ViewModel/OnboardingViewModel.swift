//
//  OnboardingViewModel.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import Foundation
import Combine

class OnboardingViewModel: ObservableObject {
    
    var objectWillChange = PassthroughSubject<Void, Never>()
    private let networkManager = NetworkManager()
    
    var articles = [Article]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    func saveArticleRequiredInfo(category: Category, country: Country) {
        ArticleHelper.saveArticleRequiredInfo(category: category, country: country)
    }
}
