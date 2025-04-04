//
//  NoArticleView.swift
//  Newsy
//
//  Created by Salma Atef on 03/04/2025.
//

import SwiftUI

struct NoArticleView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image("no-image")
                .frame(width: 100, height: 100, alignment: .center)
            Text("No Articles found")
                .font(.callout)
                .multilineTextAlignment(.center)
        }
    }
    
}

#Preview {
    NoArticleView()
}
