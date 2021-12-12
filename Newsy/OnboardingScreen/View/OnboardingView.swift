//
//  OnboardingView.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnboardingView: View {
    
    @ObservedObject var onboardingViewModel = OnboardingViewModel()
    
    @State private var selectedCountry = ""
    @State private var presentPicker = false
    @State private var showView = false
    
    var countryNamesArray:[String] {
        Country.allCases.map{"\($0.flag) \($0.description)"}
    }
    
    var body: some View {
        
        if showView {
            HomeView()
        } else {
            NavigationView(content: {
                mainViewList
                    .navigationBarTitle(Text("Onboarding".localized()), displayMode: .large)
            })
        }
    }
    
    
    private var mainViewList: some View {
        List {
            Section(header: Text(verbatim: "Countries".localized())) {
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
            
            Section(header: Text(verbatim: "Categories".localized())) {
                ForEach(Category.allCases, id: \.self) { category in
                    Button(action: {
                        onboardingViewModel.saveArticleRequiredInfo(category: category, country: Country(countryName: String(selectedCountry.dropFirst(2))))
                        showView = true
                    }) {
                        HStack {
                            Text(category.description.localized().capitalizeFirstLetter()).foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right").foregroundColor(.black)
                        }
                    }
                }
            }.disabled(selectedCountry == "")
                .opacity(selectedCountry == "" ? 0.3 : 1)
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        
    }
}

struct CustomPickerTextView: View {
    @Binding var presentPicker: Bool
    @Binding var fieldString: String
    var placeholder: String
    var body: some View {
        TextField(placeholder, text: $fieldString).disabled(true)
            .overlay(
                Button(action: {
                    withAnimation {
                        presentPicker = true
                    }
                }) {
                    Rectangle().foregroundColor((Color.clear))
                }
            )
    }
}

struct CustomPickerView: View {
    var items: [String]
    @State private var filteredItems: [String] = []
    @State private var filterString: String = ""
    @State private var frameHeight: CGFloat = 400
    @Binding var pickerField: String
    @Binding var presentPicker: Bool
    var body: some View {
        let filterBinding = Binding<String> (
            get: { filterString },
            set: {
                filterString = $0
                if filterString != "" {
                    filteredItems = items.filter{$0.lowercased().contains(filterString.lowercased())}
                } else {
                    filteredItems = items
                }
                setHeight()
            }
        )
        return ZStack {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Button(action: {
                            withAnimation {
                                presentPicker = false
                            }
                        }) {
                            Text("Cancel")
                        }
                        .padding(10)
                        Spacer()
                    }
                    .background(Color(UIColor.darkGray))
                    .foregroundColor(.white)
                    TextField("Search", text: filterBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    List {
                        ForEach(filteredItems, id: \.self) { item in
                            Button(action: {
                                pickerField = item
                                presentPicker = false
                            }) {
                                Text(item)
                            }
                        }
                    }
                }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(.horizontal,10)
                .frame(height: frameHeight)
                .padding(.top, 20)
                //                Spacer()
            }
        }
        //        .edgesIgnoringSafeArea(.all)
        .onAppear {
            filteredItems = items
            setHeight()
        }
    }
    
    fileprivate func setHeight() {
        withAnimation {
            if filteredItems.count > 5 {
                frameHeight = 400
            } else if filteredItems.count == 0 {
                frameHeight = 130
            } else {
                frameHeight = CGFloat(filteredItems.count * 45 + 160)
            }
        }
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
