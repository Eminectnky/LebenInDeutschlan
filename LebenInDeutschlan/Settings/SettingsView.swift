//
//  SettingsView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 16.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedState: String = "Bayern" // Varsayılan eyalet
    @State private var showAlert = false
    @State private var showStateSelection = false

    let stateImages: [String: String] = [
        "Baden Württemberg": "state_flag_bw",
        "Bayern": "state_flag_by",
        "Berlin": "state_flag_be",
        "Brandenburg": "state_flag_bb",
        "Bremen": "state_flag_hb",
        "Hamburg": "state_flag_hh",
        "Hessen": "state_flag_he",
        "Mecklenburg Vorpommern": "state_flag_mv",
        "Niedersachsen": "state_flag_ni",
        "Nordrhein Westfalen": "state_flag_nw",
        "Rheinland Pfalz": "state_flag_rp",
        "Saarland": "state_flag_sl",
        "Sachsen": "state_flag_sn",
        "Sachsen Anhalt": "state_flag_st",
        "Schleswig Holstein": "state_flag_sh",
        "Thüringen": "state_flag_th"
    ]

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Leben In Deutschlan")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(width: 400, height: 50)
                        .padding(.trailing, 50)
                }
                .background(Color.gray)
                
                Spacer()
                
                // Federal Eyalet Butonu
                Button(action: {
                    showAlert = true
                }) {
                    HStack {
                        if let imageName = stateImages[selectedState] {
                            Image(imageName)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(5)
                                .padding()
                        }
                         
                        VStack(alignment: .leading) {
                            Text("Federal Eyalet")
                            Text(selectedState)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Federal Devleti Değiştirmek Üzeresiniz"),
                        message: Text("Federal devleti değiştirirseniz, tüm sınavlar sıfırlanacak."),
                        primaryButton: .destructive(Text("Evet")) {
                            showStateSelection = true
                        },
                        secondaryButton: .cancel(Text("Hayır"))
                    )
                }
                
                Spacer()
                
            }
            .sheet(isPresented: $showStateSelection) {
                StateSelectionView(selectedState: $selectedState)
            }
        }
    }
}

#Preview {
    SettingsView()
}
