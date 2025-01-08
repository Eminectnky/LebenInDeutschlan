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
                let percentage = Double(item.value) / Double(totalQuestions) * 100
                SectorMark(
                    angle: .value("Oran", item.value),
                    innerRadius: .ratio(0.5),
                    outerRadius: .ratio(0.9)
                )
                .foregroundStyle(color(for: item.name))
                .annotation(position: .overlay) {
                    Text(formatPercentage(percentage))
                        .font(.body)
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .frame(width: 300, height: 300)
            .padding()
            
            // Legend Section
            HStack(spacing: 20) {
                LegendItem(color: .green, text: "Doğru")
                LegendItem(color: .red, text: "Yanlış")
                LegendItem(color: .gray, text: "Boş")
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sınav Sonucu")
    }
    
    func color(for name: String) -> Color {
        switch name {
        case "Doğru":
            return .green
        case "Yanlış":
            return .red
        case "Boş":
            return .gray
        default:
            return .blue
        }
    }
    
    func formatPercentage(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

struct LegendItem: View {
    var color: Color
    var text: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
            Text(text)
                .font(.body)
                .bold()
        }
    }
}

struct MacroData {
    let name: String
    let value: Int
}

#Preview {
    NavigationView {
        ExamResultView(correctAnswers: 9, wrongAnswers: 20, emptyAnswers: 4)
    }
}
