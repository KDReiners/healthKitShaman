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
        List {
            HStack {
            }
            Divider()
            VStack {
                ForEach(1..<slices.count, id:\.self) { i in
                    HStack {
                        Text(slices[i].quantityType)
                        Text(BaseServices.standardDateFormatter.string(from:slices[i].logDate))
                    }
                    
                }
            }
        }
    }
}

//struct DataNavigatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        DataNavigatorView (detailObject: AddendumModel(), recordIndex: 0)
//    }
//}
