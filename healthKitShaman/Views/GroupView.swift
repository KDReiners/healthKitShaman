//
//  GroupView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 26.06.21.
//

import SwiftUI
import Combine
enum aggregationStyle {
    case D
    case W
//    case M
//    case J
}
struct listHeader: View {
    var body: some View {
        HStack() {
            ListHeaderView(text: "Log", alignement: .center, font: .body, foreGroundColor: .black)
            ListHeaderView(text: "Type", alignement: .center, font: .body, foreGroundColor: .black)
            ListHeaderView(text: "Source", alignement: .center, font:.body, foreGroundColor: .black)
            ListHeaderView(text: "Device", alignement: .center, font: .body, foreGroundColor: .black)
            ListHeaderView(text: "Value", alignement: .center, font: .body, foreGroundColor: .black)
            ListHeaderView(text: "Unit", alignement: .center, font: .body, foreGroundColor: .black)
        }
    }
}
struct FilledButton: ButtonStyle {
    let isSelected: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(isSelected ? .black : .gray)
            .padding(5)
            .cornerRadius(8)
            .border(isSelected ? .blue : .clear)
    }
}
struct CalendarView: View {
    @State var selectedButtons: [Bool] = [ false, true, false , false]
    @State var subs = Set<AnyCancellable>() // Cancel onDisappear
    @State var filterInterval: DateInterval!
    @ObservedObject var logViewModel: LogModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Button("D") {
                setFilter(aggregationStyle: .D, index: 0)
            }.buttonStyle(FilledButton(isSelected: selectedButtons[0]))
            Button("W") {
                setFilter(aggregationStyle: .W, index: 1)
            }.buttonStyle(FilledButton(isSelected: selectedButtons[1]))
            Button("M") {
                deactivate(skipIndex: 2)
                selectedButtons[2].toggle()
            }.buttonStyle(FilledButton(isSelected: selectedButtons[2]))
            Button("J") {
                deactivate(skipIndex: 3)
                selectedButtons[3].toggle()
            }.buttonStyle(FilledButton(isSelected: selectedButtons[3]))
        }.onAppear { trackScrollWheel() }
    }
    func setFilter(aggregationStyle: aggregationStyle, index: Int) {
        deactivate(skipIndex: index)
        if selectedButtons[index] == false {
            selectedButtons[index].toggle()
            switch aggregationStyle {
            case .D:
                logViewModel.filterInterval = DateInterval(start: logViewModel.filterInterval.end, end: logViewModel.filterInterval.end )
            case .W:
                let startDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: logViewModel.filterInterval.end)!
                logViewModel.filterInterval = DateInterval(start: startDate, end: logViewModel.filterInterval.end)
    //        case .M:
    //            <#code#>
    //        case .J:
    //            <#code#>
            }
        }
        logViewModel.applyLimits()
        
    }
    func deactivate(skipIndex: Int) {
        for (index, _) in selectedButtons.enumerated() {
            if index != skipIndex {
                selectedButtons[index] = false
            }
        }
    }
    func trackScrollWheel() {
        NSApp.publisher(for: \.currentEvent)
            .filter { event in event?.type == .leftMouseDragged }
                .throttle(for: .milliseconds(200),
                          scheduler: DispatchQueue.main,
                          latest: true)
                .sink {
                    if let event = $0 {
                        if event.deltaX > 0 { print("right") }
                        if event.deltaX < 0 { print("left") }
                        if event.deltaY > 0 { print("down") }
                        if event.deltaY < 0 { print("up") }
                    }
                }
                .store(in: &subs)
        }
}
struct GroupView: View {
    @ObservedObject var logViewModel = LogModel()
    var limitInterval: DateInterval!
    var filterInterval: DateInterval!
    @State var dateFrom: Date?
    @State var dateTo: Date?
    init() {
        limitInterval = self.logViewModel.getLimits()
        if dateFrom == nil {
            let startDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: limitInterval.end)!
            filterInterval = DateInterval(start: startDate, end: limitInterval.end)
            logViewModel.filterInterval = filterInterval
        }
        self.logViewModel.applyLimits()
    }
    var body: some View {
    VStack {
        CalendarView(logViewModel: logViewModel)
        Divider()
        listHeader().frame(height: 20)
        List {
            OutlineGroup(logViewModel.categories, id: \.value, children: \.children) { tree in
                ListHeaderView(text: BaseServices.standardDateFormatter.string(from: tree.value.timeStamp!), alignement: .center, font: .body, foreGroundColor: .primary)
                ListHeaderView(text: stuffText(text:tree.value.log2quantitytype!.hk_quantitytype ?? ""), alignement: .bottomLeading, font: .body, foreGroundColor: .secondary)
                ListHeaderView(text: tree.value.log2source?.hk_name ?? "", alignement: .center, font: .body, foreGroundColor: .secondary)
                ListHeaderView(text: stuffText(text: tree.value.log2Device?.hk_name ?? ""), alignement: .center, font: .body, foreGroundColor: .secondary)
                ListHeaderView(text: "\(tree.value.value)", alignement: .center, font: .body, foreGroundColor: .primary)
                ListHeaderView(text: tree.value.log2quantitytype!.preferredUnit ?? "", alignement: .center, font: .body, foreGroundColor: .secondary)
            }   
            .frame(maxHeight: .infinity)
        }
    }
    .fixedSize(horizontal: true, vertical: false)
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}

