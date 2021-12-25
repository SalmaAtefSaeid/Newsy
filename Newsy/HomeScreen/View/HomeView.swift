//
//  HomeView.swift
//  Newsy
//
//  Created by Salma Atef on 10/12/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    @State var searchText = ""
    @State var searching = false
    @State var shouldPopToRootView = false
    var timer = Timer.publish(every: 30 * 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if shouldPopToRootView {
            OnboardingView()
        } else {
            NavigationView {
                
                if homeViewModel.networkError != nil {
                    RetryView(text: homeViewModel.networkError?.localizedDescription ?? "error", homeViewModel: homeViewModel)
                } else {
                    if homeViewModel.noArticleFound == true {
                        NoArticleView()
                    } else {
                        if homeViewModel.articles.isEmpty {
                            ProgressView("Downloading...")
                                .progressViewStyle(CircularProgressViewStyle())
                        } else {
                            VStack(alignment: .leading) {
                                SearchBar(searchText: $searchText)
                                    .padding([.top, .bottom], 16)
                                homeViewList
                            }
                            .navigationTitle(homeViewModel.category ?? "")
                            .navigationBarHidden(homeViewModel.category == nil)
                            .toolbar {
                                
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        homeViewModel.deleteArticles()
                                        shouldPopToRootView = true
                                    }) {
                                        Image(uiImage: UIImage(named: "arrows-circle")!)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    .frame(width: 40, height: 40, alignment: .trailing)
                                }
                            }
                        }
                    }
                }
            }
            .accentColor(Color.black)
            .onReceive(timer) { _ in
                homeViewModel.getArticles(updateTheArticles: true)
            }
        }
    }
    
    private var homeViewList: some View  {
        List(homeViewModel.articles.filter{$0.title?.hasPrefix(searchText) ?? false || searchText == ""}, id:\.self) { article in
            NavigationLink(
                destination: DetailsView(article: article)
                    .navigationBarTitle(Text(article.title ?? ""), displayMode: .large)
            ) {
                ArticlesView(article: article)
                    .frame(height: UIScreen.main.bounds.width / 4 * 3, alignment: .center)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                    .cornerRadius(8)
                    .padding([.top, .bottom], 16)
            }
        }
    }
    
    struct ArticlesView : View {
        let article: Article
        
        var body: some View {
            ZStack(alignment: .bottom) {
                let placeholder = UIImage(named: "no-image")!
                WebImage(url: URL(string: article.urlToImage ?? "")).placeholder(Image(uiImage: placeholder))
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 70, height: UIScreen.main.bounds.width / 4 * 3, alignment: .center)
                    .scaledToFit()
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.3)
                
                VStack {
                    Text(verbatim: article.source?.name ?? "")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .lineLimit(nil)
                        .padding([.leading, .trailing])
                        .frame(width: UIScreen.main.bounds.width - 70, alignment: .bottomLeading)
                    
                    Text(verbatim: article.title ?? "")
                        .foregroundColor(.white)
                        .font(.headline)
                        .lineLimit(nil)
                        .padding([.leading, .bottom, .trailing])
                        .frame(width: UIScreen.main.bounds.width - 70, alignment: .bottomLeading)
                }
            }
            .cornerRadius(8)
            .padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 8)
            .shadow(color: .black, radius: 8, x: 0, y: 0)
            .frame(width:  UIScreen.main.bounds.width - 65, height: UIScreen.main.bounds.width / 4 * 3, alignment: .center)
        }
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("search", text: $searchText, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                }).foregroundColor(.primary)
                
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            if showCancelButton  {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)}
}

struct RetryView: View {
    
    let text: String
    var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            Button(action: {
                homeViewModel.getArticles(updateTheArticles: true)
            })
            {
                Text("Try again")
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
                    .clipShape(Capsule())
            }
        }
    }
}

struct NoArticleView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: UIImage(named: "no-image")!)
                .frame(width: 100, height: 100, alignment: .center)
            Text("No Articles found")
                .font(.callout)
                .multilineTextAlignment(.center)
        }
    }
    
}


extension UIApplication {
    
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}
