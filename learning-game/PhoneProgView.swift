import SwiftUI
import LineChartView

struct PhoneProgView: View {
    @State private var selection: String = "Parent1"
    
    //Garbage values for demo purposes, This needs to be linked to a database that stores the values
    private let data1: [LineChartData] = [
        LineChartData(310, label: "1-12-2023 10:31 AM"),
        LineChartData(230, label: "1-13-2023 11:27 AM"),
        LineChartData(490, label: "1-14-2023 10:31 AM"),
        LineChartData(520, label: "1-15-2023 10:31 AM"),
        LineChartData(310, label: "1-16-2023 10:31 AM"),
        LineChartData(430, label: "1-17-2023 11:27 AM"),
        LineChartData(290, label: "1-18-2023 10:31 AM"),
        LineChartData(320, label: "1-19-2023 10:31 AM"),
        LineChartData(510, label: "1-19-2023 10:31 AM"),
        LineChartData(230, label: "1-20-2023 11:27 AM"),
        LineChartData(390, label: "1-21-2023 10:31 AM"),
        LineChartData(420, label: "1-22-2023 10:31 AM"),
        LineChartData(310, label: "1-23-2023 10:31 AM"),
        LineChartData(530, label: "1-24-2023 11:27 AM"),
        LineChartData(590, label: "1-25-2023 10:31 AM"),
        LineChartData(420, label: "1-26-2023 10:31 AM"),
    ]
    
    private let data2: [LineChartData] = [
        LineChartData(110, label: "1-12-2023 10:31 AM"),
        LineChartData(130, label: "1-13-2023 11:27 AM"),
        LineChartData(190, label: "1-14-2023 10:31 AM"),
        LineChartData(120, label: "1-15-2023 10:31 AM"),
        LineChartData(110, label: "1-16-2023 10:31 AM"),
        LineChartData(130, label: "1-17-2023 11:27 AM"),
        LineChartData(190, label: "1-18-2023 10:31 AM"),
        LineChartData(120, label: "1-19-2023 10:31 AM"),
        LineChartData(510, label: "1-19-2023 10:31 AM"),
        LineChartData(230, label: "1-20-2023 11:27 AM"),
        LineChartData(390, label: "1-21-2023 10:31 AM"),
        LineChartData(420, label: "1-22-2023 10:31 AM"),
        LineChartData(310, label: "1-23-2023 10:31 AM"),
        LineChartData(530, label: "1-24-2023 11:27 AM"),
        LineChartData(590, label: "1-25-2023 10:31 AM"),
        LineChartData(420, label: "1-26-2023 10:31 AM"),
    ]
            
    private let data3: [LineChartData] = [
        LineChartData(310, label: "1-12-2023 10:31 AM"),
        LineChartData(230, label: "1-13-2023 11:27 AM"),
        LineChartData(490, label: "1-14-2023 10:31 AM"),
        LineChartData(520, label: "1-15-2023 10:31 AM"),
        LineChartData(310, label: "1-16-2023 10:31 AM"),
        LineChartData(430, label: "1-17-2023 11:27 AM"),
        LineChartData(290, label: "1-18-2023 10:31 AM"),
        LineChartData(320, label: "1-19-2023 10:31 AM"),
        LineChartData(510, label: "1-19-2023 10:31 AM"),
        LineChartData(230, label: "1-20-2023 11:27 AM"),
        LineChartData(390, label: "1-21-2023 10:31 AM"),
        LineChartData(420, label: "1-22-2023 10:31 AM"),
        LineChartData(310, label: "1-23-2023 10:31 AM"),
        LineChartData(530, label: "1-24-2023 11:27 AM"),
        LineChartData(590, label: "1-25-2023 10:31 AM"),
        LineChartData(420, label: "1-26-2023 10:31 AM"),
    ]
    
    func selector(input: String) -> [LineChartData] {
        let data : [LineChartData]
        
        if (input == "Parent1") {
            data = data1
        }else if (input == "Parent2") {
            data = data2
        }else if (input == "Guardian1") {
            data = data3
        }else{
            data = [
            LineChartData(0),
            ]
        }
        return data
    }
    

        var body: some View {
            
            let data = selector(input: selection)
            
            let chartParameters = LineChartParameters(
            data: data,
            labelColor: .green,
            secondaryLabelColor: .secondary,
            labelsAlignment: .left,
            dataPrecisionLength: 0,
            dataSuffix: " Points",
            indicatorPointColor: .green,
            indicatorPointSize: 20,
            lineColor: .green,
            lineSecondColor: .yellow,
            lineWidth: 3,
            dotsWidth: 8,
            displayMode: .default,
            dragGesture: true,
            hapticFeedback: true
        )
        
        VStack{
            dropdownMenu(
                content: ["Parent1", "Parent2", "Guardian1"],
                selection: $selection,
                activeTint: .primary.opacity(0.1),
                inActiveTint: .primary.opacity(0.05),
                dynamic: false
            )
            .frame(width: 160)
            
            Spacer()
            
            LineChartView(lineChartParameters: chartParameters)
                .frame(height: 500)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct PhoneProgView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneProgView()
    }
}
