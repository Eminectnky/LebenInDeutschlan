//
//  HomeView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 15.04.2024.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView{
            
        ZStack{
            VStack{
                Spacer()
                Image("deutsch")
                    .resizable()
                    .frame(width: 250, height: 250)
                Spacer()
                
                Text("Testen Sie Ihre Deutschkenntnisse und kommen Sie Ihrem Traumleben einen Schritt näher!")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundColor(.gray)
                    .padding()
                
              
                Spacer()
                
            }
        }
    }
        
       
    }
}

#Preview {
    HomeView()
}
