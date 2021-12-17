
//
//  HKimporter.swift
//  HealthKitImporter
//
//  Created by boaz saragossi on 11/7/17.
//  Copyright © 2017 boaz saragossi. All rights reserved.
//

import Foundation
import CoreData

extension CustomStringConvertible {
    var description : String {
        var description: String = ""
        //if self is AnyObject {
        //    description = "***** \(type(of: self)) - <\(unsafeAddressOf((self as AnyObject)))>***** \n"
        //} else {
        description = "***** \(type(of: self)) *****\n"
        //}
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}

class HKRecord: CustomStringConvertible {
    var type: String = String()
    var value: Double = 0
    var unit: String?
    var sourceName: String = String()
    var sourceVersion: String = String()
    var startDate: Date = Date()
    var endDate: Date = Date()
    var creationDate: Date = Date()
    
    //for workouts
    var activityType: String = String()
    var totalEnergyBurned: Double = 0
    var totalDistance: Double = 0
    var totalEnergyBurnedUnit: String = String()
    var totalDistanceUnit: String = String()

    var metadata: [String:String]?
}

class HKimporter : NSObject, XMLParserDelegate {

    let moc = PersistenceController.shared.localContainer.viewContext
    var allHKRecords: [HKRecord] = []
    
    var eName: String = String()
    var currRecord: HKRecord = HKRecord.init()
    

    
    
    convenience init(completion:@escaping ()->Void) {
        self.init()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == "Record" {
            currRecord.type = attributeDict["type"]!
            currRecord.sourceName = attributeDict["sourceName"] ??  ""
            currRecord.sourceVersion = attributeDict["sourceVersion"] ??  ""
            currRecord.value = Double(attributeDict["value"] ?? "0") ?? 0
            currRecord.unit = attributeDict["unit"] ?? ""
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss Z"
            if let date = formatter.date(from: attributeDict["startDate"]!) {
                currRecord.startDate = date
            }
            if let date = formatter.date(from: attributeDict["endDate"]!){
                currRecord.endDate = date
            }
            
            if currRecord.startDate >  currRecord.endDate {
                currRecord.startDate = currRecord.endDate
            }
            
            if let date = formatter.date(from: attributeDict["creationDate"]!){
                currRecord.creationDate = date
            }
        } else if elementName == "MetadataEntry" {
            currRecord.metadata = attributeDict
        } else if elementName == "Workout" {
            print(attributeDict)
            currRecord.type = "" //HKObjectType.workoutType().identifier
            currRecord.activityType = "" //activityByName(activityName: attributeDict["workoutActivityType"] ?? "")
            currRecord.sourceName = attributeDict["sourceName"] ??  ""
            currRecord.sourceVersion = attributeDict["sourceVersion"] ??  ""
            currRecord.value = Double(attributeDict["duration"] ?? "0") ?? 0
            currRecord.unit = attributeDict["durationUnit"] ?? ""
            currRecord.totalDistance = Double(attributeDict["totalDistance"] ?? "0") ?? 0
            currRecord.totalDistanceUnit = attributeDict["totalDistanceUnit"] ??  ""
            currRecord.totalEnergyBurned = Double(attributeDict["totalEnergyBurned"] ?? "0") ?? 0
            currRecord.totalEnergyBurnedUnit = attributeDict["totalEnergyBurnedUnit"] ??  ""
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss Z"
            if let date = formatter.date(from: attributeDict["startDate"]!) {
                currRecord.startDate = date
            }
            if let date = formatter.date(from: attributeDict["endDate"]!){
                currRecord.endDate = date
            }
            
            if currRecord.startDate >  currRecord.endDate {
                currRecord.startDate = currRecord.endDate
            }
            
            if let date = formatter.date(from: attributeDict["creationDate"]!){
                currRecord.creationDate = date
            }
        } else if elementName == "Correlation" {
            return
        } else {
            return
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Record" || elementName == "Workout" {
            allHKRecords.append(currRecord)
            storeInPrimaNota(input: currRecord)
            print(currRecord.description)
            DispatchQueue.main.async {
//                self.readCounterLabel?.text = "\(self.allHKRecords.count)"
            }
           /*saveHKRecord(item: currRecord, withSuccess: {
                // success
                //print("record added to array")
            }, failure: {
                // fail
                print("fail to process record")
            }) */
        }
    }
    func storeInPrimaNota(input: HKRecord) -> Void {
        var entry = PrimaNota(context: moc)
        entry.type = input.type
        entry.value = input.value
        entry.unit = input.unit
        entry.sourceName = input.sourceName
        entry.sourceVersion = input.sourceVersion
        entry.startDate = input.startDate
        entry.endDate = input.endDate
        entry.creationDate = input.creationDate
        try? moc.save()
    }
}
