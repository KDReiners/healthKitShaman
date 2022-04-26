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
    var slices: Array<Slice>
    var recordIndex: Int
    init(masterObject: T1, detailObject: T2, recordIndex: Int) {
        self.masterObject = masterObject
        self.detailObject = detailObject
        self.recordIndex = recordIndex
        self.slices = detailObject.slices as! Array<Slice>
        self.slices = slices.filter { slice in
            return slice.quantityType == "Nutrition"
        }
    }
    var body: some View {
        List {
            HStack {
            }
            Divider()
            VStack {
                ForEach(1..<detailObject.slices.count, id:\.self) { i in
                    HStack {
                        Text(($detailObject.slices[i].wrappedValue as! Slice).quantityType)
                        Text(BaseServices.standardDateFormatter.string(from:($detailObject.slices[i].wrappedValue as! Slice).logDate))
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
