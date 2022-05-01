//
//  DataNavigatorView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 10.04.22.
//

import SwiftUI
import healthKitPackage
struct DataNavigatorView <T1, T2>: View where T1: GenericViewModel, T2: GenericTimeCapsule {
    @ObservedObject var masterObject: T1
    @ObservedObject var detailObject: T2
    @State var childrenRelationKey: String
    var slices: Array<Slice>
    var recordIndex: Int
    init(masterObject: T1, detailObject: T2, recordIndex: Int, childrenRelationKey: String) {
        self.masterObject = masterObject
        self.detailObject = detailObject
        self.recordIndex = recordIndex
        self.slices = detailObject.slices as! Array<Slice>
        self.childrenRelationKey = childrenRelationKey
        self.slices = slices.filter { slice in
            return slice.quantityType == (masterObject.items[recordIndex] as! NSManagedObject).value(forKey: childrenRelationKey) as! String
        }
    }
    var body: some View {
        ScrollView {
            HStack {
            }
            Divider()
            VStack {
                ForEach(0..<slices.count, id:\.self) { i in
                    HStack {
                        Text(BaseServices.standardDateFormatter.string(from:slices[i].sliceDateInterval.start)).frame(width: 180, alignment: .leading).font(.system(.body, design: .monospaced))
                        Text(stuffText(text:slices[i].quantityType)).frame(width: 350, alignment: .leading).font(.system(.body, design: .monospaced))
                        valueField(value: slices[i].value).frame(width: 250, alignment: .trailing).font(.system(.body, design: .monospaced))
                    }
                }
            }
        }
        
    }
}

struct valueField: View {
    var value: Any
    var body: some View {
        Text(tryCast(_: value))
    }
    func tryCast(_ val:Any) -> String {
        let valueFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
                return formatter
            }()
        switch val {
        case is String, is NSString:
            return val as! String
        case is Int, is Double:
            return valueFormatter.string(from: val as! NSNumber)!
        default:
            return ""
        }
    }
}
struct DataNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        DataNavigatorView(masterObject: AddendumTypeModel(), detailObject: AddendumTimeCapsules(resolution: 3600), recordIndex: 0, childrenRelationKey: "name")
    }
}
