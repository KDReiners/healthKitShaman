//
//  HeathKitDetailView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 01.11.21.
//

import SwiftUI
import healthKitPackage

struct PropertiesListView <T>: View where T: GenericViewModel {
    @ObservedObject var detailObject: T
    var recordIndex: Int
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    var body: some View {
        List {
            VStack {
                Spacer()
                Label("System", systemImage: "pencil.slash")
                    .systemLabelStyle()
                LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                    ForEach(0..<detailObject.readOnlyAttributes.count, id: \.self)  { i in
                        Text(detailObject.readOnlyAttributes[i].key)
                            .systemTextLabelStyle()
                        Text(Binding.bindingFromString(detailObject: $detailObject.items[recordIndex].wrappedValue as! NSManagedObject, key: detailObject.readOnlyAttributes[i].key).wrappedValue)
                            .systemTextContentStyle()
                    }
                }
            }
            Spacer()
            VStack {
                Spacer()
                Label("User", systemImage: "pencil").userLabelStyle()
                LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                    ForEach(0..<detailObject.readWriteAttributes.count, id: \.self) { i in
                        Text(detailObject.readWriteAttributes[i].key)
                            .systemTextContentStyle()
                            VariantTextFieldView(
                                masterObject: detailObject, detailObject: $detailObject.items[recordIndex].wrappedValue as! NSManagedObject, key: detailObject.readWriteAttributes[i].key)
                            .userTextFieldStyle()
                    }
                }
            }
            DataNavigatorView(masterObject: detailObject, detailObject: LogTimeCapsules(resolution: 3600, quantityType: (detailObject.items[recordIndex] as! NSManagedObject).value(forKey: "hk_quantitytype") as! String), recordIndex: recordIndex, childrenRelationKey: "quantitytype")
        }
    }
}

struct PropertiesListView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesListView(detailObject: QuantityTypeModel(), recordIndex: 0)
    }
}
