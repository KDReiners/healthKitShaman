//
//  QuantityTypeModel.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 19.11.21.
//

import Foundation
class QuantityTypeModel: Model<Quantitytype> {
    @Published var result: [Quantitytype]!
    init() {
        let readOnlyFields = ["id", "preferredUnit", "hk_quantitytype"]
        super.init(readOnlyFields: readOnlyFields)
    }
    override var items: [Quantitytype] {
        get {
            return result
        }
        set
        {
            result = newValue.sorted(by: { $1.hk_quantitytype ?? "" > $0.hk_quantitytype ?? "" })
        }
    }

}
