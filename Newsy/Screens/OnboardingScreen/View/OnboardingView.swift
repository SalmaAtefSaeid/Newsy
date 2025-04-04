//
//  OnboardingView.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import SwiftUI

import SwiftUI

struct OnboardingView: View {
    
    @StateObject var onboardingViewModel = OnboardingViewModel()
    
    @State private var selectedCountry = ""
    @State private var presentPicker = false
    @State private var showView = false
    
    var countryNamesArray: [String] {
        Country.allCases.map { "\($0.flag) \($0.description)" }
    }
    
    var body: some View {
        if showView {
            SearchArticlesHomeView() // Navigate to the search view
        } else {
            VStack {
                mainViewList
                    .navigationBarTitle(Text("Onboarding".localized()), displayMode: .large)
                Spacer()
            }
        }
    }
    
    private var mainViewList: some View {
        List {
            Section(header: Text("Countries".localized())) {
                CustomPickerTextView(presentPicker: $presentPicker,
                                     fieldString: $selectedCountry,
                                     placeholder: "Please select a country first.")
                
                if presentPicker {
                    CustomPickerView(items: countryNamesArray,
                                     pickerField: $selectedCountry,
                                     presentPicker: $presentPicker)
                        .zIndex(1.0)
                }
            }
            
            Section(header: Text("Categories".localized())) {
                ForEach(Category.allCases, id: \.self) { category in
                    Button(action: {
                        onboardingViewModel.saveArticleRequiredInfo(category: category, country: Country(countryName: String(selectedCountry.dropFirst(2))))
                        showView = true
                    }) {
                        HStack {
                            Text(category.description.localized().capitalizeFirstLetter())
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .disabled(selectedCountry.isEmpty)
            .opacity(selectedCountry.isEmpty ? 0.3 : 1)
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
    }
}
