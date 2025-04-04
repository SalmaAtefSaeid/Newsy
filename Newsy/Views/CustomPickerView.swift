//
//  CustomPickerView.swift
//  Newsy
//
//  Created by Salma Atef on 04/04/2025.
//

import SwiftUI

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
            }
        }
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

#Preview {
    CustomPickerView(items: [], pickerField: .constant(""), presentPicker: .constant(true))
}
