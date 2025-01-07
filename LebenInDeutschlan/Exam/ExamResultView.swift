import SwiftUI
import Charts

struct ExamResultView: View {
    var correctAnswers: Int
    var wrongAnswers: Int
    var emptyAnswers: Int
    
    var totalQuestions: Int {
        correctAnswers + wrongAnswers + emptyAnswers
    }
    
    var data: [MacroData] {
        [
            MacroData(name: "Doğru", value: correctAnswers),
            MacroData(name: "Yanlış", value: wrongAnswers),
            MacroData(name: "Boş", value: emptyAnswers)
        ]
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Doğru: \(correctAnswers)")
                    .font(.title3)
                    .bold()
                Text("Yanlış: \(wrongAnswers)")
                    .font(.title3)
                    .bold()
                Text("Boş: \(emptyAnswers)")
                    .font(.title3)
                    .bold()
                Text("Toplam: \(totalQuestions)")
                    .font(.title3)
                    .bold()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
            
            Chart(data, id: \.name) { item in
                SectorMark(
                    angle: .value("Oran", item.value),
                    innerRadius: .ratio(0.5),
                    outerRadius: .ratio(0.9)
                )
                .foregroundStyle(by: .value("Durum", item.name))
            }
            .frame(width: 300, height: 300)
            .padding()
            .chartLegend(.visible)
            .chartLegend(position: .bottom)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sınav Sonucu")
    }
}

struct MacroData {
    let name: String
    let value: Int
}

#Preview {
    NavigationView {
        ExamResultView(correctAnswers: 15, wrongAnswers: 3, emptyAnswers: 2)
    }
}
