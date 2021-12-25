//
//  NewsyApp.swift
//  Newsy
//
//  Created by Salma Atef on 09/12/2021.
//

import SwiftUI

@main
struct NewsyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashView(viewRouter: ViewRouter.sharedInstance())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
