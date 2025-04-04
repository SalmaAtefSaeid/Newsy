//
//  OnboardingAndSearchTabView.swift
//  Newsy
//
//  Created by Salma Atef on 04/04/2025.
//

import SwiftUI

struct OnboardingAndSearchTabView: View {
    var body: some View {
        NavigationStack {
            VStack {
                if ViewRouter.sharedInstance().currentPage == "onboardingView" {
                    OnboardingView()
                } else if ViewRouter.sharedInstance().currentPage == "homeView" {
                    SearchArticlesHomeView()
                }
            }
            .navigationBarHidden(false)
        }
    }
}

#Preview {
    OnboardingAndSearchTabView()
}
