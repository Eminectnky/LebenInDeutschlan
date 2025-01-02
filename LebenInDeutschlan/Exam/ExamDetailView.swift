import SwiftUI
import SwiftUIPager

struct ExamDetailView: View {
    var questions: [QuestionJsonData]
    var examNumber: Int
    
    @StateObject var page: Page = .first()
    @State private var answeredCount = 0
    @State private var timer = 0
    
    var body: some View {
        VStack {
            // Üst Başlık
            HStack {
                Text("Sınav #\(examNumber)")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    // Bitir Butonu
                }) {
                    Text("Bitir")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            // Cevaplanmış Kutusu
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
            
            // Soruların Pager ile Gösterimi
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
                                Image(systemName: "square")
                                    .foregroundColor(.black)
                                Text(option.text)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal)
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
            
            // Sayfa Geçiş Butonları
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
    }
    
    func handleOptionSelection(for index: Int, optionIndex: Int) {
        // Cevaplama mantığı buraya eklenebilir
        answeredCount += 1
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
