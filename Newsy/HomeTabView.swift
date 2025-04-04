//
//  HomeTabView.swift
//  Newsy
//
//  Created by Salma Atef on 03/04/2025.
//

import SwiftUI

struct HomeTabView: View {
    
    var body: some View {
        TabView {
            ArticlesListHomeView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            OnboardingAndSearchTabView()
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            //                    BookmarkTabView()
            //                        .tabItem {
            //                            Label("Saved", systemImage: "bookmark")
            //                        }
        }
        .accentColor(.red)
    }
}

#Preview {
    HomeTabView()
}
