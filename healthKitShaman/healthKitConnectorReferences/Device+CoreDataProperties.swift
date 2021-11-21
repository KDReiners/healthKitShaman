//
//  Device+CoreDataProperties.swift
//  healthKitConnector
//
//  Created by Klaus-Dieter Reiners on 27.05.21.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var hk_firmwareVersion: String?
    @NSManaged public var hk_hardwareVersion: String?
    @NSManaged public var isdefault: Bool
    @NSManaged public var hk_localIdentifier: String?
    @NSManaged public var hk_manufacturer: String?
    @NSManaged public var hk_model: String?
    @NSManaged public var hk_name: String?
    @NSManaged public var hk_softwareVersion: String?
    @NSManaged public var hk_udiDeviceIdentifier: String?
    @NSManaged public var devices2Sources: NSSet?

}

// MARK: Generated accessors for devices2Sources
extension Device {

    @objc(addDevices2SourcesObject:)
    @NSManaged public func addToDevices2Sources(_ value: Source)

    @objc(removeDevices2SourcesObject:)
    @NSManaged public func removeFromDevices2Sources(_ value: Source)

    @objc(addDevices2Sources:)
    @NSManaged public func addToDevices2Sources(_ values: NSSet)

    @objc(removeDevices2Sources:)
    @NSManaged public func removeFromDevices2Sources(_ values: NSSet)

}

extension Device : Identifiable {

}
