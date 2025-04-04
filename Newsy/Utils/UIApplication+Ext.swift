//
//  UIApplication+Ext.swift
//  Newsy
//
//  Created by Salma Atef on 03/04/2025.
//

import SwiftUI

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
