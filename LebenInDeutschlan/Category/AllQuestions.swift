//
//  AllQuestions.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 28.04.2024.
//

import SwiftUI
import SwiftUIPager

struct IndexedQuestion: Identifiable, Equatable {
    let id = UUID()
    var index: Int
    let question: QuestionJsonData
    var imageName: String? {
        return ImageHelper.provideImageName(questionId: question.id)
    }
}

struct AllQuestions: View {
    @State private var questionDataModel: [QuestionJsonData] = []
    @StateObject var page: Page = .first()
    @State private var indexedQuestions: [IndexedQuestion] = []
    @State private var selectedOptions: [UUID: Int] = [:]
    @State private var correctOptions: [UUID: Int] = [:]
    @State private var correctCount: Int = 0
    @State private var wrongCount: Int = 0
    @State private var answeredCount: Int = 0
    
    var body: some View {
        VStack {
            scoreView
                .padding(.bottom)
            
            Pager(page: page, data: indexedQuestions, id: \.id) { indexedQuestion in
                VStack(alignment: .leading, spacing: 20) {
                    Spacer().frame(height: 20)
                    Text("Question: \(indexedQuestion.index + 1)")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text(indexedQuestion.question.title)
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if let imageName = indexedQuestion.imageName {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    ForEach(indexedQuestion.question.options.indices, id: \.self) { optionIndex in
                        let option = indexedQuestion.question.options[optionIndex]
                        Button(action: {
                            handleOptionSelection(for: indexedQuestion, optionIndex: optionIndex)
                        }) {
                            
                            HStack {
                                Image(systemName: getImageName(for: indexedQuestion, optionIndex: optionIndex))
                                    .foregroundColor(getOptionColor(for: indexedQuestion, optionIndex: optionIndex))
                                    .imageScale(.large)
                                Text(option.text)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                            .background(getOptionBackgroundColor(for: indexedQuestion, optionIndex: optionIndex))
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, -5)
                    }
                    
                    Spacer()
                }
                .frame(width: 360, height: 600)
                .background(
                    Color(.blue).opacity(0.2)
                    
                )
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .horizontal()
            .itemSpacing(10)
            .onPageChanged { newIndex in
                if correctOptions[indexedQuestions[newIndex].id] != nil || selectedOptions[indexedQuestions[newIndex].id] != nil {
                    answeredCount += 1
                }
            }
            .onAppear {
                self.loadQuestions()
            }
            
            HStack {
                Button(action: {
                    if page.index > 0 {
                        page.update(.new(index: page.index - 1))
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .padding()
                        .foregroundColor(.black)
                        .font(.system(size: 24, weight: .bold))
                }
                
                Text("\(page.index + 1)/\(indexedQuestions.count)")
                    .font(.title3)
                
                Button(action: {
                    if page.index < indexedQuestions.count - 1 {
                        page.update(.new(index: page.index + 1))
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .padding()
                        .foregroundColor(.black)
                        .font(.system(size: 24, weight: .bold))
                }
            }
            .padding()
            .frame(width: 370, height: 60)
            .background(
                Color(.blue).opacity(0.2)
            )
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .navigationBarTitle("All Questions", displayMode: .inline)
    }
    
    private var scoreView: some View {
        VStack{
            Text("Right: \(correctCount)/\(indexedQuestions.count)")
            Text("Wrong: \(wrongCount)/\(indexedQuestions.count)")
            Text("Answered: \(answeredCount)/\(indexedQuestions.count)")
        }
        .frame(width: 370, height: 60)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    func loadQuestions() {
        if let jsonDataModel = loadData() {
            self.indexedQuestions = jsonDataModel
                .enumerated().map { (index, question) in
                    return IndexedQuestion(index: index, question: question)
                }
                .shuffled()
        }
    }
    
    func handleOptionSelection(for indexedQuestion: IndexedQuestion, optionIndex: Int) {
        let correctOptionIndex = indexedQuestion.question.options.firstIndex { $0.isAnswer } ?? -1
        
        if correctOptions[indexedQuestion.id] == nil && selectedOptions[indexedQuestion.id] == nil {
            answeredCount += 1
        }
        
        if optionIndex == correctOptionIndex {
            correctOptions[indexedQuestion.id] = optionIndex
            correctCount += 1
        } else {
            selectedOptions[indexedQuestion.id] = optionIndex
            correctOptions[indexedQuestion.id] = correctOptionIndex
            wrongCount += 1
        }
    }
    
    func getImageName(for indexedQuestion: IndexedQuestion, optionIndex: Int) -> String {
        if let selectedOptionIndex = selectedOptions[indexedQuestion.id], selectedOptionIndex == optionIndex {
            return "xmark.square"
        } else if let correctOptionIndex = correctOptions[indexedQuestion.id], correctOptionIndex == optionIndex {
            return "checkmark.square"
        } else {
            return "square"
        }
    }
    
    func getOptionColor(for indexedQuestion: IndexedQuestion, optionIndex: Int) -> Color {
        if let selectedOptionIndex = selectedOptions[indexedQuestion.id], selectedOptionIndex == optionIndex {
            return .red
        } else if let correctOptionIndex = correctOptions[indexedQuestion.id], correctOptionIndex == optionIndex {
            return .green
        } else {
            return .black
        }
    }
    
    func getOptionBackgroundColor(for indexedQuestion: IndexedQuestion, optionIndex: Int) -> Color {
        if let selectedOptionIndex = selectedOptions[indexedQuestion.id], selectedOptionIndex == optionIndex {
            return Color.red        } else if let correctOptionIndex = correctOptions[indexedQuestion.id], correctOptionIndex == optionIndex {
                return Color.green
            } else {
                return Color.clear
            }
    }
}

#Preview {
    AllQuestions()
}
