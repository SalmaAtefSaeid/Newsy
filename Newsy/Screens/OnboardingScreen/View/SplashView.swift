//
//  SplashView.swift
//  Newsy
//
//  Created by Salma Atef on 11/12/2021.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                HomeTabView()
            } else {
                Image("splash")
                    .frame(width:  UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4 * 3, alignment: .center)
                    .padding([.trailing, .leading], 20)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}


struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
