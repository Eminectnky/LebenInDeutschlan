//
//  ExamResultView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 4.01.2025.
//

import SwiftUI

struct ExamResultView: View {
    var body: some View {
        VStack {
            Text("Sınav Sonucu")
                .font(.largeTitle)
                .padding()
            
            Text("Tebrikler! Sınavı başarıyla tamamladınız.")
                .font(.body)
                .multilineTextAlignment(.center)
        }
        .navigationTitle("Sınav Sonucu")
    }
}

#Preview {
    ExamResultView()
}
