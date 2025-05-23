import SwiftUI
import SwiftUIPager

struct ExamDetailView: View {
    var questions: [QuestionJsonData]
    var examNumber: Int
    var onComplete: () -> Void
    
    @StateObject var page: Page = .first()
    @State private var answeredCount = 0
    @State private var timer = 0
    @State private var selectedOptions: [Int: Int] = [:]
    
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var emptyAnswers = 0
    @State private var showAlert = false
    @State private var navigateToResult = false
    @State private var isExamCompleted = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Sınav #\(examNumber)")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    showAlert = true
                }) {
                    Text("Bitir")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            if !isExamCompleted {
                HStack {
                    Text("Cevaplanmış")
                    Text("\(answeredCount) / \(questions.count)")
                        .bold()
                    
                    Spacer()
                    
                    Text("\(formattedTime(seconds: timer))")
                }
                .padding()
                .frame(width: 370, height: 60)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            
            Pager(page: page, data: questions.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 20) {
                    Spacer().frame(height: 20)
                    
                    Text("Soru: \(questions[index].order)")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text(questions[index].title)
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(questions[index].options.indices, id: \.self) { optionIndex in
                        let option = questions[index].options[optionIndex]
                        Button(action: {
                            handleOptionSelection(for: index, optionIndex: optionIndex)
                        }) {
                            HStack {
                                ZStack {
                                    // Dış çerçeve
                                    Rectangle()
                                        .strokeBorder(Color.black, lineWidth: 2)
                                        .frame(width: 20, height: 20)

                                    // Seçim yapıldığında mavi arka plan ve tik işareti
                                    if selectedOptions[index] == optionIndex {
                                        Rectangle()
                                            .fill(Color.blue)
                                            .frame(width: 20, height: 20)

                                        Image(systemName: "checkmark")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14, weight: .bold)) // Tik işareti boyutu
                                    }
                                }

                                // Seçenek metni
                                Text(option.text)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                        .padding(.horizontal)
                        .disabled(selectedOptions[index] != nil) // Seçim yapıldıktan sonra seçenek devre dışı
                    }
                    
                    Spacer()
                }
                .frame(width: 360, height: 600)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .horizontal()
            .itemSpacing(10)

            
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
                
                Text("\(page.index + 1)/\(questions.count)")
                    .font(.title3)
                
                Button(action: {
                    if page.index < questions.count - 1 {
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
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .onAppear {
            startTimer()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Emin misin?"),
                message: Text("Sınav sonlandırılacak."),
                primaryButton: .default(Text("Evet"), action: {
                    calculateResults()
                    isExamCompleted = true // Sınav tamamlandı
                    navigateToResult = true // Sonuç sayfasına git
                }),
                secondaryButton: .cancel(Text("Hayır"))
            )
        }
        .background(
            NavigationLink(
                destination: ExamResultView(
                    correctAnswers: correctAnswers,
                    wrongAnswers: wrongAnswers,
                    emptyAnswers: emptyAnswers
                ),
                isActive: $navigateToResult
            ) {
                EmptyView()
            }
            .isDetailLink(false)
        )
    }
    
    func handleOptionSelection(for index: Int, optionIndex: Int) {
        if selectedOptions[index] == nil {
            answeredCount += 1
        }
        selectedOptions[index] = optionIndex
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timer += 1
            if navigateToResult {
                timer.invalidate()
            }
        }
    }
    
    func calculateResults() {
        correctAnswers = questions.filter {
            if let selectedOptionIndex = selectedOptions[$0.order - 1] {
                return $0.options[selectedOptionIndex].isAnswer
            }
            return false
        }.count
        wrongAnswers = answeredCount - correctAnswers
        emptyAnswers = questions.count - answeredCount
        
        
    }
    
    
    func formattedTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
