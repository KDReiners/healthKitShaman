//
//  LogEntry.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 29.11.21.
//

import Foundation
import CreateML
struct TargetEntry {
    var log: Log
    var attachedQuantityTypeLogs: [Log]!
    init(log: Log) {
        attachedQuantityTypeLogs = Shaman.logModel.items.filter { (dependantLog) -> Bool in
            dependantLog.timeStamp! < log.timeStamp! && dependantLog.log2quantitytype?.friendlyname != "Blutzucker"
        }
        self.log = log
    }
}
