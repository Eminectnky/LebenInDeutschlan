import SwiftUI
import SwiftUIPager

struct FederalState: View {
    @State private var indexedQuestions: [IndexedQuestion] = []
    @State private var selectedOptions: [UUID: Int] = [:]
    @State private var correctOptions: [UUID: Int] = [:]
    @State private var correctCount: Int = 0
    @State private var wrongCount: Int = 0
    @State private var answeredCount: Int = 0
    @StateObject var page: Page = .first()
    var stateKey: String
    @State private var stateName: String = ""
    
    // ViewModel'inizi kullanmak için
    @StateObject var viewModel = MainContentSharedViewModel()
    
    // federal_state.json dosyasını yüklemek için model
    struct FederalStateInfo: Codable {
        let id: Int
        let name: String
        let flag: String
        let coat_of_arms: String
        let question_sub_category_id: Int
        let key: String
    }
    
    // stateKey'i federalStateId'ye eşleştirme
    func getFederalStateId(for stateKey: String) -> Int? {
        guard let federalStates = loadFederalStates() else {
            return nil
        }
        return federalStates.first(where: { $0.key == stateKey })?.id
    }
    
    // federal_state.json dosyasını yükleme
    func loadFederalStates() -> [FederalStateInfo]? {
        guard let url = Bundle.main.url(forResource: "federal_states", withExtension: "json") else {
            print("federal_states.json bulunamadı")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let federalStates = try JSONDecoder().decode([FederalStateInfo].self, from: data)
            return federalStates
        } catch {
            print("federal_states.json çözümleme hatası: \(error)")
            return nil
        }
    }
    
    // Seçilen şehrin sorularını yükleme
    func loadStateQuestions() {
        print("loadStateQuestions() çağrıldı")
        
        guard let federalStateId = getFederalStateId(for: stateKey) else {
            print("Geçersiz stateKey veya federalStateId bulunamadı")
            return
        }
        
        // State adını almak için
        if let federalStates = loadFederalStates() {
            if let stateInfo = federalStates.first(where: { $0.key == stateKey }) {
                stateName = stateInfo.name
                print("Seçilen eyalet: \(stateName)")
            } else {
                print("stateKey: \(stateKey) için eyalet bulunamadı")
            }
        } else {
            print("Federal eyaletler yüklenemedi")
        }
        
        // ViewModel'den soruları alıyoruz
        if let stateQuestions = viewModel.federalStateQuestions.first(where: { $0.federalStateId == federalStateId }) {
            self.indexedQuestions = stateQuestions.list.enumerated().map { (index, question) in
                return IndexedQuestion(index: index, question: question)
            }.shuffled()
            print("Eyalet \(stateName) için \(indexedQuestions.count) soru yüklendi")
        } else {
            print("federalStateId \(federalStateId) için soru bulunamadı")
        }
    }
    
    
    
    // IndexedQuestion yapısı
    struct IndexedQuestion: Identifiable, Equatable {
        let id = UUID()
        let index: Int
        let question: Questions
        
        static func == (lhs: IndexedQuestion, rhs: IndexedQuestion) -> Bool {
            return lhs.question.id == rhs.question.id
        }
    }
    
    
    var body: some View {
        VStack {
            scoreView
                .padding(.bottom)
            
            if viewModel.isLoading {
                ProgressView("Yükleniyor...")
            } else {
                if indexedQuestions.isEmpty {
                    Text("Bu eyalet için soru bulunamadı.")
                } else {
                    Pager(page: page, data: indexedQuestions, id: \.id) { indexedQuestion in
                        VStack(alignment: .leading, spacing: 20) {
                            Spacer().frame(height: 20)
                            Text("Soru: \(indexedQuestion.index + 1)")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Text(indexedQuestion.question.text)
                                .font(.headline)
                                .padding(.horizontal)
                            
                            if let imageName = indexedQuestion.question.imageName {
                                // Görseli yüklemek için
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
                                .disabled(correctOptions[indexedQuestion.id] != nil || selectedOptions[indexedQuestion.id] != nil) // Sorunun cevabı verilmişse tıklamayı kapat
                                .padding(.horizontal)
                                .padding(.vertical, -5)
                            }
                            
                            
                            Spacer()
                        }
                        .frame(width: 360, height: 600)
                        .background(Color(.blue).opacity(0.2))
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
                        self.loadStateQuestions()
                    }
                    
                    paginationControls
                }
            }
        }
        .navigationBarTitle("\(stateName) Soruları", displayMode: .inline)
        .onAppear {
        }
        .onReceive(viewModel.$isLoading) { isLoading in
            if !isLoading {
                self.loadStateQuestions()
            }
        }
    }
    
    private var scoreView: some View {
        VStack {
            Text("Right: \(correctCount)/\(indexedQuestions.count)")
            Text("Wrong: \(wrongCount)/\(indexedQuestions.count)")
            Text("Answered: \(answeredCount)/\(indexedQuestions.count)")
        }
        .frame(width: 370, height: 60)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    private var paginationControls: some View {
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
        .background(Color(.blue).opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    func handleOptionSelection(for indexedQuestion: IndexedQuestion, optionIndex: Int) {
        // Daha önce cevap verilmişse işlemi durdur
        if correctOptions[indexedQuestion.id] != nil || selectedOptions[indexedQuestion.id] != nil {
            return
        }
        
        let correctOptionIndex = indexedQuestion.question.options.firstIndex { $0.isAnswer } ?? -1
        
        // Yanıtlanan soru sayısını artır
        answeredCount += 1
        
        if optionIndex == correctOptionIndex {
            correctOptions[indexedQuestion.id] = optionIndex
            correctCount += 1
        } else {
            selectedOptions[indexedQuestion.id] = optionIndex
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
            return Color.red.opacity(0.2)
        } else if let correctOptionIndex = correctOptions[indexedQuestion.id], correctOptionIndex == optionIndex {
            return Color.green.opacity(0.2)
        } else {
            return Color.clear
        }
    }
}

struct FederalState_Previews: PreviewProvider {
    static var previews: some View {
        // Örnek olarak Berlin (stateKey: "be") kullanıyoruz
        FederalState(stateKey: "hb")
    }
}
