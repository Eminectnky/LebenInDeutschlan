//
//  StateSelectionView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 11.11.2024.
//

import SwiftUI

struct StateSelectionView: View {
    @Binding var selectedState: String
    @Environment(\.dismiss) var dismiss
    
    @State private var newSelectedState: String
    
    init(selectedState: Binding<String>) {
        self._selectedState = selectedState
        self._newSelectedState = State(initialValue: selectedState.wrappedValue)
    }
    
    let states = [
        "Baden Württemberg", "Bayern", "Berlin", "Brandenburg", "Bremen",
        "Hamburg", "Hessen", "Mecklenburg Vorpommern", "Niedersachsen",
        "Nordrhein Westfalen", "Rheinland Pfalz", "Saarland", "Sachsen",
        "Sachsen Anhalt", "Schleswig Holstein", "Thüringen"
    ]
    
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
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 6) {
                        ForEach(states, id: \.self) { state in
                            Button(action: {
                                newSelectedState = state
                            }) {
                                HStack {
                                    if let imageName = stateImages[state] {
                                        Image(imageName)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .cornerRadius(5)
                                    }
                                    Text(state)
                                        .foregroundColor(newSelectedState == state ? .green : .primary)
                                    Spacer()
                                    if newSelectedState == state {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                    }
                                }
                                .padding()
                                .background(newSelectedState == state ? Color.green.opacity(0.4) : Color.clear)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    Button(action: {
                        newSelectedState = selectedState
                        dismiss()
                    }) {
                        Text("İptal")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        selectedState = newSelectedState
                        dismiss()
                    }) {
                        Text("Tamam")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        
        .padding(.horizontal)
    }
}

#Preview {
    StateSelectionView(selectedState: .constant("Bayern"))
}

