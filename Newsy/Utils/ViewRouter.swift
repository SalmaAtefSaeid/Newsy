//
//  ViewRouter.swift
//  Newsy
//
//  Created by Salma Atef on 11/12/2021.
//

import Foundation

class ViewRouter: NSObject, ObservableObject {
    
    private static var shared: ViewRouter = ViewRouter()
    @Published var currentPage: String
    
    class func sharedInstance() -> ViewRouter {
        return shared
    }

    private override init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            currentPage = "onboardingView"
        } else {
            currentPage = "homeView"
        }
    }
    
    func saveData(didLaunchBefore: Bool) {
        UserDefaults.standard.set(didLaunchBefore, forKey: "didLaunchBefore")
    }
    
}
