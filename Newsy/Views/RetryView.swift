//
//  RetryView.swift
//  Newsy
//
//  Created by Salma Atef on 03/04/2025.
//

import SwiftUI

struct RetryView: View {
    
    let text: String
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            Button(action: {
                action()
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

#Preview {
    RetryView(text: "", action: {})
}
