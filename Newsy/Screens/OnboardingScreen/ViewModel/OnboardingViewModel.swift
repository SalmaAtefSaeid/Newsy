//
//  OnboardingViewModel.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    @Published var articles = [Article]()
    
    func saveArticleRequiredInfo(category: Category, country: Country) {
        ArticleHelper.saveArticleRequiredInfo(category: category, country: country)
        ViewRouter.sharedInstance().saveData(didLaunchBefore: true)
    }
}
