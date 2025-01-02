import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

struct ExamView: View {
    @State private var exams: [[QuestionJsonData]] = []
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Leben In Deutschland")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .background(Color.gray)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(0..<exams.count, id: \.self) { index in
                            NavigationLink(destination: ExamDetailView(questions: exams[index], examNumber: index + 1)) {
                                VStack {
                                    Text("Sınav #\(index + 1)")
                                        .foregroundColor(.black)
                                        .padding(.leading, 20)
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.3))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                loadExams()
            }
        }
    }

    func loadExams() {
        if let questions = loadData() {
            let shuffledQuestions = questions.shuffled()
            exams = shuffledQuestions.chunked(into: 33)
        }
    }
}
