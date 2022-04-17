
//
//  HKimporter.swift
//  HealthKitImporter
//
//  Created by boaz saragossi on 11/7/17.
//  Copyright © 2017 boaz saragossi. All rights reserved.
//

import Foundation
import CoreData
import healthKitPackage
import CSV
struct HKImporter {
    init(url: URL)
    {
        let libreViewModel = Libre3Model()
        libreViewModel.deleteAllRecords()
        var rowCount = 0
        let stream = InputStream(fileAtPath: url.path)
        let reader = try! CSVReader(stream: stream!)
        while let row = reader.next() {
            if rowCount > 1 {
                let entry = libreViewModel.insertRecord()
                entry.carbohydratesservings = Int16(row[10]) ?? 0
                entry.carbohydratesunits = Int16(row[9]) ?? 0
                entry.correctioninsulinunits = Int16(row[17]) ?? 0
                entry.depotinsulinunits = Int16(row[12]) ?? 0
                entry.device = row[0]
                entry.devicetimestamp = BaseServices.convertToStandardDate(dateString: row[2])
                entry.glucosescan = Double(row[5]) ?? 0
                entry.glucosespathway = Double(row[4]) ?? 0
                entry.glucoseteststrips = Int16(row[14]) ?? 0
                entry.insulinchangebyuserUnits = Int16(row[18]) ?? 0
                entry.ketoneunits = Int16(row[15]) ?? 0
                entry.mealinsulinunits = Int16(row[16]) ?? 0
                entry.nonnumericdepotinsulin = Bool(row[11]) ?? false
                entry.nonnumericfooddata = Bool(row [8]) ?? false
                entry.nonnumericrapidactinginsulin = Bool(row[6]) ?? false
                entry.notes = row[13]
                entry.rapidactinginsulin = Int16(row[7]) ?? 0
                entry.recordingtype = Int16(row[3]) ?? -1
                entry.serialnumber = row[1]
            }
            rowCount+=1
        }
        libreViewModel.saveChanges()
    }
}
