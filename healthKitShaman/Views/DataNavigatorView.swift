//
//  DataNavigatorView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 10.04.22.
//

import SwiftUI
import healthKitPackage
struct DataNavigatorView <T>: View where T: GenericViewModel {
    @ObservedObject var detailObject: T
    var recordIndex: Int
    init(detailObject: T, recordIndex: Int) {
        self.detailObject = detailObject
        self.recordIndex = recordIndex

    }
    var body: some View {
        List {
            HStack {
            }
            Divider()
            VStack {
            }
        }
    }
}

//struct DataNavigatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        DataNavigatorView (detailObject: AddendumModel(), recordIndex: 0)
//    }
//}
