//
//  shaman.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 23.11.21.
//

import Foundation
import CoreML
import CreateML
import SwiftUI

struct Shaman {
    internal static var logModel = LogModel()
    internal static var targetEntries = [TargetEntry]()
    static func learn() ->Void {
        let targetValues = logModel.items.filter { (hk) -> Bool in
            hk.log2quantitytype?.friendlyname == "Blutzucker"

        }
        targetValues.forEach { tv in
            var logEntry = TargetEntry(log: tv)
            targetEntries.append(logEntry)
        }
        let dataArrayInt = targetValues.map{ $0.value!.intValue }
        var data = try! MLDataTable(dictionary: ["TargetValue" : dataArrayInt])
        print(data)
        let squaresArrayInt = (1...5).map{$0 * $0}
        var table = try! MLDataTable(dictionary: ["Ints" :  squaresArrayInt])
        print(table)
        let squaresColumnDouble = table["Ints"].map(to: Double.self)
        table.addColumn(squaresColumnDouble, named: "Doubles")
        print(table)
    }
    
}


