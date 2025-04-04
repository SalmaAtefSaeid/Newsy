//
//  BackButton.swift
//  Newsy
//
//  Created by Salma Atef on 03/04/2025.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .foregroundColor(Color(.label))
                .font(.title3)
        }
    }
}

#Preview {
    BackButton()
}
