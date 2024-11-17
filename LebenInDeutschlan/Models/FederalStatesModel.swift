//
//  FederalStatesModel.swift
//  LebenInDeutschland
//
//  Created by Emine CETINKAYA on 1.07.2024.
//
import Foundation
import SwiftUI

struct FederalStateQuestion: Codable, Identifiable {
    let federalStateId: Int
    let list: [Questions]
    let mainCategoryId: Int
    let mainText: String
    let subCategoryId: Int
    let subText: String
    
    var id: Int {
        federalStateId
    }
}

struct Questions: Codable, Identifiable , Equatable{
    let federalStateId: Int
    let isQuestionHasImage: Bool
    let mainCategoryId: Int
    let options: [Options]
    let questionId: Int
    let subCategoryId: Int
    let text: String
    let imageName: String? 
    var id: Int {
        questionId
    }
}

struct Options: Codable, Identifiable, Equatable {
    let id: Int
    let isAnswer: Bool
    let text: String
}

class MainContentSharedViewModel: ObservableObject {
    @Published var federalStateQuestions: [FederalStateQuestion] = []
    @Published var isLoading: Bool = true

    init() {
        loadInitialData()
    }

    func loadInitialData() {
        if let url = Bundle.main.url(forResource: "all_federal_state_questions", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let questions = try? decoder.decode([FederalStateQuestion].self, from: data) {
                DispatchQueue.main.async {
                    self.federalStateQuestions = questions
                    self.isLoading = false
                    print("Yüklenen federalStateQuestions: \(questions.count) eyalet")
                }
            } else {
                print("Sorular çözümlenemedi")
                self.isLoading = false
            }
        } else {
            print("all_federal_state_questions.json yüklenemedi")
            self.isLoading = false
        }
    }
}

