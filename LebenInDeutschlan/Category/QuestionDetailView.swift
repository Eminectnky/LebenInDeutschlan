//
//  QuestionDetailView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 10.10.2024.
//

import SwiftUI

struct QuestionDetailView: View {
    let question: FederalStateQuestion
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.mainText)
                .font(.largeTitle)
                .bold()
            
            Text(question.subText)
                .font(.title2)
                .foregroundColor(.secondary)
            
            ForEach(question.list) { questionDetail in
                VStack(alignment: .leading, spacing: 10) {
                    Text(questionDetail.text)
                        .font(.headline)
                    
                    ForEach(questionDetail.options, id: \.id) { option in
                        HStack {
                            Text(option.text)
                                .padding(8)
                                .background(option.isAnswer ? Color.green : Color.red)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Question Detail")
    }
}

#Preview {
    QuestionDetailView(question: FederalStateQuestion(federalStateId: 1, list: [], mainCategoryId: 1, mainText: "Sample", subCategoryId: 1, subText: "Sample Sub"))
}
