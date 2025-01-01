//
//  AllQuestionsModel.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 30.04.2024.
//

import Foundation

struct Option: Codable, Equatable, Identifiable {
    var id = Int()
    let text: String
    let isAnswer: Bool
    
    static func == (lhs: Option, rhs: Option) -> Bool {
           return lhs.id == rhs.id &&
                  lhs.text == rhs.text
       }
}

struct QuestionJsonData: Codable, Equatable {
    let id: Int
    let order: Int
    let isQuestionHasImage: Bool
    let imageUrl: String
    let title: String
    let dirtyText: String
    let options: [Option]
    let state: String?
    
    
    static func == (lhs: QuestionJsonData, rhs: QuestionJsonData) -> Bool {
          return lhs.id == rhs.id &&
                 lhs.title == rhs.title &&
                 lhs.options == rhs.options
      }
}

func loadData() -> [QuestionJsonData]? {
    guard let url = Bundle.main.url(forResource: "all_question_data", withExtension: "json") else {
        print("JSON dosyası bulunamadı.")
        return nil
    }
    
    print("JSON dosyası yolu: \(url.path)")
    
    do {
        let data = try Data(contentsOf: url)
        let jsonDataModel = try JSONDecoder().decode([QuestionJsonData].self, from: data)
        return jsonDataModel
    } catch {
        print("JSON dosyası yüklenirken hata: \(error.localizedDescription)")
        return nil
    }
    
    
}

