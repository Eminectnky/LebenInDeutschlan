//
//  ContentView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 15.04.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
              HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                       
                        
                }
            
            CategoryView()
               .tabItem {
                  Image(systemName: "square.3.layers.3d")
                  Text("Category")
            }
            
            ExamView()
                .tabItem {
                    Image(systemName: "checkmark")
                    Text("Exam")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
            
        }
    }
}

#Preview {
    ContentView()
}
