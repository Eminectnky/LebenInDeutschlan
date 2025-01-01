//
//  CategoryView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 16.04.2024.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Leben In Deutschlan")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(width: 400, height: 50)
                        .padding(.trailing, 50)
                }
                .background(Color.gray)
                
                ScrollView {
                    NavigationLink(destination: AllQuestions()) {
                        Text("All Questions")
                            .multilineTextAlignment(.leading)
                            .frame(width: 370, height: 50)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                
                    NavigationLink(destination: FederalState(stateKey: getStateKey(for: appState.selectedState))) {
                        Text("Federal State")
                            .multilineTextAlignment(.leading)
                            .frame(width: 370, height: 50)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()

                    Text("Main Category")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    NavigationLink(destination: PolitikInDerDemokratie()) {
                        Text("Politik in der Demokratie")
                            .frame(width: 370, height: 50)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    func getStateKey(for stateName: String) -> String {
        switch stateName {
        case "Baden Württemberg": return "bw"
        case "Bayern": return "by"
        case "Berlin": return "be"
        case "Brandenburg": return "bb"
        case "Bremen": return "hb"
        case "Hamburg": return "hh"
        case "Hessen": return "he"
        case "Mecklenburg Vorpommern": return "mv"
        case "Niedersachsen": return "ni"
        case "Nordrhein Westfalen": return "nw"
        case "Rheinland Pfalz": return "rp"
        case "Saarland": return "sl"
        case "Sachsen": return "sn"
        case "Sachsen Anhalt": return "st"
        case "Schleswig Holstein": return "sh"
        case "Thüringen": return "th"
        default: return "by"
        }
    }
}
