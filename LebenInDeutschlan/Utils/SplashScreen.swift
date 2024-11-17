//
//  SplashScreen.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 15.04.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            ContentView()
        }else{
            
            ZStack {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    VStack{
                        
                        Image("splash")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                    }
                    
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation{
                                self.isActive = true
                            }
                            
                        }
                    }
                    
                }
            }
        }
    }
}
#Preview {
    SplashScreen()
}
