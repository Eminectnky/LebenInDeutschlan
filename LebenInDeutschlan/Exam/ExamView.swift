//
//  ExamView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 16.04.2024.
//

import SwiftUI

struct ExamView: View {
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("Leben In Deutschlan")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(width: 400, height: 50)
                        .padding(.trailing, 50)
                }
                .background(Color.gray)
                
                ZStack{
                    ScrollView{
                        
                    }
                }
                
                
            }
        }

    }
}

#Preview {
    ExamView()
}
