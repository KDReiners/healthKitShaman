//
//  NumberTextFieldView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 09.10.21.
//

import SwiftUI
import Combine

struct NumberTextFieldView: View {
    @State var anyNumber: NSNumber?
    @State var anyNumberString: String = ""
    @State var didAppear: Bool = false
    var detailObject: NSManagedObject
    var key: String
    var body: some View {
        HStack {
            let numberBinding = Binding.bindFromNSNumber(detailObject: detailObject, key: key)
            
            TextField("minutes", text: self.$anyNumberString.onChange(valueChanged))
                .onReceive(Just(self.anyNumberString)) { newValue in
                    let filtered  = newValue.filter { $0.isNumber }
                    if filtered != newValue {
                        self.anyNumberString = filtered
                    }
                    if didAppear {
                        numberBinding.wrappedValue = (Int(filtered) ?? -1) as NSNumber
                    }
                    
//                    detailObject.setValue(self.anyNumber, forKey: key)
                }.onAppear {
                    anyNumber = Binding.bindFromNSNumber(detailObject: detailObject, key: key).wrappedValue
                    if anyNumber != nil {
                        $anyNumberString.wrappedValue = anyNumber!.stringValue
                    }
                    else {
                        $anyNumberString.wrappedValue = "0"
                    }
                    didAppear = true
                    
                }
                                    
//            Stepper("minutes", value: $anyNumber).onChange(of: self.anyNumber) { newValue in
//                self.anyNumberString = String(newValue)
//                self.anyNumber = newValue
//            }
            .labelsHidden()
        }
    }
}

//struct NumberTextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        NumberTextFieldView()
//    }
//}
