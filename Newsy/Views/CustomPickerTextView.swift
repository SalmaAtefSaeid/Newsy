//
//  CustomPickerTextView.swift
//  Newsy
//
//  Created by Salma Atef on 04/04/2025.
//

import SwiftUI

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

#Preview {
    CustomPickerTextView(presentPicker: .constant(true), fieldString: .constant(""), placeholder: "")
}
