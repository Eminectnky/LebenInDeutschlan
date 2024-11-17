//
//  CategoryComponents.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 5.07.2024.
//

import SwiftUI

struct QuestionContentNavigationView: View {
    var currentPositionText: String
    var onNextClick: () -> Void
    var onPrevClick: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onPrevClick) {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Text(currentPositionText)
            Spacer()
            Button(action: onNextClick) {
                Image(systemName: "chevron.right")
            }
        }
        .padding()
    }
}


