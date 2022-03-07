//
//  MainView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 07.09.21.
//

import SwiftUI
import healthKitPackage

struct DirectoryView: View
{
    @ObservedObject var quantityTypeViewModel = QuantityTypeModel()
    @ObservedObject var deviceViewModel = DeviceModel()
    @ObservedObject var sourceViewModel = SourceModel()
    @State private var isExpanded = true
    @State var select: NSManagedObject?
    var body: some View
    {
        NavigationView {
            List
            {
                DisclosureGroup("Loggings", isExpanded: $isExpanded) {
                    NavigationLink("Logs", destination: GroupView())
                        .disclosureElementStyle()
                }
                .disclosureGroupStyle()
                DisclosureGroup("Input/Output Types", isExpanded: $isExpanded) {
                    ForEach(0..<quantityTypeViewModel.items.count, id: \.self) {
                        i in

                        NavigationLink(quantityTypeViewModel.items[i].hk_quantitytype ?? "", destination: PropertiesListView(detailObject: quantityTypeViewModel, recordIndex: i), tag: quantityTypeViewModel.items[i], selection: $select)
                    }
                    .disclosureElementStyle()
                }
                .disclosureGroupStyle()
                DisclosureGroup("Devices", isExpanded: $isExpanded) {
                    ForEach(0..<deviceViewModel.items.count, id: \.self) { i in
                        NavigationLink(deviceViewModel.items[i].hk_name ?? "", destination: PropertiesListView(detailObject: deviceViewModel, recordIndex: i), tag: deviceViewModel.items[i], selection: $select)
                    }
                    .disclosureElementStyle()
                }
                .disclosureGroupStyle()
                DisclosureGroup("Source", isExpanded: $isExpanded) {
                    ForEach(0..<sourceViewModel.items.count, id: \.self) { i in
                        NavigationLink(sourceViewModel.items[i].hk_name ?? "", destination: PropertiesListView(detailObject: sourceViewModel, recordIndex: i), tag: sourceViewModel.items[i], selection: $select)
                    }
                }
                DisclosureGroup("Data Manager", isExpanded: $isExpanded) {
                    NavigationLink("Xml-Import", destination: ImportView())
                }
                
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 180, idealWidth: 200, maxWidth: .infinity)
            .onDisappear {
                if select?.hasChanges == true {
                    do {
                        try select?.managedObjectContext?.save()
                    }
                    catch {
                        fatalError()
                    }
                }
            }
        }
    }
}
struct DirectoryView_Previews: PreviewProvider {
    static let logViewModel = LogModel()
    static let quantityTypeViewModel = QuantityTypeModel()
    static let deviceViewModel = DeviceModel()
    static var previews: some View {
        DirectoryView()
            .environmentObject(logViewModel)
            .environmentObject(quantityTypeViewModel)
            .environmentObject(deviceViewModel)
    }
}

