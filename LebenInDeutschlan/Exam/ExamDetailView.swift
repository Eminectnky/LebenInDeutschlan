//
//  ExamDetailView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 30.12.2024.
//

import SwiftUI

struct ExamDetailView: View {
    var questions: [QuestionJsonData]
    var examNumber: Int
    
    @State private var currentQuestionIndex = 0
    @State private var answeredCount = 0
    @State private var timer = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Sınav #\(examNumber)")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Button(action: {
                }) {
                    Text("Bitir")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            HStack {
                Text("Cevaplanmış")
                Text("\(answeredCount) / \(questions.count)")
                    .bold()
                
                Spacer()
                
                Text("\(formattedTime(seconds: timer))")
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Soru: \(questions[currentQuestionIndex].order)")
                    .font(.headline)
                    .padding(.top)
                
                Text(questions[currentQuestionIndex].title)
                    .font(.title3)
                
                ForEach(questions[currentQuestionIndex].options, id: \.id) { option in
                    HStack {
                        Image(systemName: "square")
                        Text(option.text)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(15)
            .padding()
            
            Spacer()
            
            HStack {
                Button(action: {
                    if currentQuestionIndex > 0 {
                        currentQuestionIndex -= 1
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .padding()
                }
                
                Spacer()
                
                Text("\(currentQuestionIndex + 1) / \(questions.count)")
                
                Spacer()
                
                Button(action: {
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            .padding(.bottom)
        }
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timer += 1
        }
    }
    
    func formattedTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
