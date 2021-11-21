//
//  NumberTextFieldView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 09.10.21.
//

import SwiftUI
import Combine

struct VariantTextFieldView<T>: View  where T: GenericViewModel {
    @State var anyNumber = 0
    @State var anyNumberString: String = ""
    @State var bindingNumber: Binding<NSNumber>!
    @ObservedObject var masterObject: T
    var detailObject: NSManagedObject
    var key: String
    var body: some View {
        HStack {
            if masterObject.attributes.filter {$0.key == key }.first?.value == "NSNumber" {
                TextField("minutes", text: self.$anyNumberString.onChange(valueChanged))
                    .onReceive(Just(self.anyNumberString)) { newValue in
                        let filtered  = newValue.filter { $0.isNumber }
                        if filtered != newValue {
                            self.anyNumberString = filtered
                        }
                        if anyNumber != Int(filtered) ?? 0 {
                            anyNumber = Int(filtered) ?? 0
                            BaseServices.logger.log("AnyNumber set to \(anyNumber) from TextField")
                        }
                    }.onAppear {
                        anyNumber = Binding.bindFromNSNumber(detailObject: detailObject, key: key).wrappedValue.intValue
                        anyNumberString = String(anyNumber)
                        bindingNumber = Binding.bindFromNSNumber(detailObject: detailObject, key: key)
                    }

                Stepper("minutes", value: $anyNumber).onChange(of: self.anyNumber) { newValue in
                    self.anyNumberString = String(newValue)
                    self.anyNumber = newValue
                    BaseServices.logger.log("AnyNumber set to \(anyNumber) from Stepper")
                    bindingNumber.wrappedValue = NSNumber(value: anyNumber)
                }
                .labelsHidden()
            }
            else {
                TextField(masterObject.readWriteAttributes.filter {$0.key == key}.first?.key ?? "", text: Binding.bindingFromString(detailObject: detailObject, key: masterObject.readWriteAttributes.filter {$0.key == key}.first?.key ?? "").onChange { newValue in
                    print("newValue: \(newValue)")
                })
            }
        }
    }
}

