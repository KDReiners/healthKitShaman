//
//  GroupView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 26.06.21.
//

import SwiftUI
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
    struct GroupView: View {
        @ObservedObject var logViewModel: LogModel
        var body: some View {
        VStack {
            listHeader().frame(height: 20)
            List {
                OutlineGroup(logViewModel.categories, id: \.value, children: \.children) { tree in
                    ListHeaderView(text: BaseServices.standardDateFormatter.string(from: tree.value.timeStamp!), alignement: .center, font: .body, foreGroundColor: .primary)
                    ListHeaderView(text: stuffText(text:tree.value.log2quantitytype!.hk_quantitytype ?? ""), alignement: .bottomLeading, font: .body, foreGroundColor: .secondary)
                    ListHeaderView(text: tree.value.log2source?.hk_name ?? "", alignement: .center, font: .body, foreGroundColor: .secondary)
                    ListHeaderView(text: stuffText(text: tree.value.log2Device?.hk_name ?? ""), alignement: .center, font: .body, foreGroundColor: .secondary)
                    ListHeaderView(text: "\(tree.value.value!)", alignement: .center, font: .body, foreGroundColor: .primary)
                    ListHeaderView(text: tree.value.log2quantitytype!.preferredUnit ?? "", alignement: .center, font: .body, foreGroundColor: .secondary)
                }
                .frame(maxHeight: .infinity)
                .onChange(of: /*@START_MENU_TOKEN@*/"Value"/*@END_MENU_TOKEN@*/, perform: { value in
                    print("Hallo")
                })
            }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(logViewModel: LogModel())
    }
}
