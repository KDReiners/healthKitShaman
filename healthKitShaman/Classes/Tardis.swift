//
//  TimeLord.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 18.04.22.
//

import Foundation
import healthKitPackage
import CoreData
public enum dataTypes: String {
    case string, double
}
public enum behaviors: String {
    case greedy, lazy
}
public class Gallifrey {
    public var Tardises: [Tardis]?
    
}
public class Tardis {
    public var dateInterval: DateInterval?
    public var timeLords: [TimeLord]?
}
public class TimeCapsule <T> {
    
}
public class TimeLord {
    var libreAnalysis = Libre3Model()
    var start: Date?
    var end: Date?
    var batch = [Libre3primanota]()
    init(resolution: Double, logKey: String, model: Model<T>) {
        let itemScope = libreAnalysis.items.sorted(by: { $1.devicetimestamp ?? Date() > $0.devicetimestamp ?? Date()}).filter {
            if $0.recordingtype == 0 && $0.device?.contains("Link") == false {
                return true
            }
            else {
                return false
            }
        }
        let newTardis = Tardis()
        start = itemScope.first!.value(forKey: logKey) as? Date
        end = start!.addingTimeInterval(TimeInterval(resolution * 60))
        newTardis.dateInterval = DateInterval(start: start!, duration:  resolution * 60.0)
        itemScope.forEach { item in
            if item.devicetimestamp! >= start! && item.devicetimestamp! <= end! {
                batch.append(item)
            }
            else {
                start = item.devicetimestamp
            }
        }
    }
}
class successor: input {
    
}
class predecessor: input {
    
}
public class input {
    public var logDate: Date!
    public var value: Any!
    public var behavior: behaviors!
    public var type: dataTypes!
    public var isTarget: Bool = false
}

