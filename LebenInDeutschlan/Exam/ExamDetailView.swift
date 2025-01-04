import SwiftUI
import SwiftUIPager

struct ExamDetailView: View {
    var questions: [QuestionJsonData]
    var examNumber: Int
    
    @StateObject var page: Page = .first()
    @State private var answeredCount = 0
    @State private var timer = 0
    @State private var selectedOptions: [Int: Int] = [:]
    
    @State private var showAlert = false
    @State private var navigateToResult = false
    
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
                                    Rectangle()
                                        .strokeBorder(Color.black, lineWidth: 2)
                                    
                                    if selectedOptions[index] == optionIndex {
                                        Rectangle()
                                            .fill(Color.blue)
                                    }
                                    
                                    Image(systemName: "checkmark")
                                        .foregroundColor(selectedOptions[index] == optionIndex ? .black : .clear)
                                }
                                .frame(width: 20, height: 20)
                                
                                Text(option.text)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                        .padding(.horizontal)
                        .disabled(selectedOptions[index] != nil)
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
                    navigateToResult = true
                }),
                secondaryButton: .cancel(Text("Hayır"))
            )
        }
        .background(
            NavigationLink(destination: ExamResultView(), isActive: $navigateToResult) {
                EmptyView()
            }
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
        }
    }
    
    func formattedTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

