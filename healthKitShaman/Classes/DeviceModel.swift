//
//  DeviceModel.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 19.11.21.
//

import Foundation
class DeviceModel: Model<Device> {
    @Published var result: [Device]!
    init() {
        let readOnlyFields = [  "hk_firmwareVersion", "hk_hardwareVersion", "hk_localIdentifier",
                                "hk_manufacturer", "hk_model", "hk_softwareVersion",
                                "hk_udiDeviceIdentifier", "uuid"]
        super.init(readOnlyFields: readOnlyFields)
    }
    override var items: [Device] {
        get {
            return result.filter { device in
                if device.device2Logs == nil {
                    return false
                }
                else {
                    return true
                }
            }
        }
        set
        {
            result = newValue.sorted(by: { $1.uuid!.uuidString > $0.uuid!.uuidString })
        }
    }
}
