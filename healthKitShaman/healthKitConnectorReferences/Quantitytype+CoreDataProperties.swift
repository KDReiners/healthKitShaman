//
//  Quantitytype+CoreDataProperties.swift
//  healthKitConnector
//
//  Created by Klaus-Dieter Reiners on 31.05.21.
//
//

import Foundation
import CoreData


extension Quantitytype {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quantitytype> {
        return NSFetchRequest<Quantitytype>(entityName: "Quantitytype")
    }

    @NSManaged public var hk_quantitytype: String
    @NSManaged public var name: String
    @NSManaged public var uuid: UUID?
    @NSManaged public var quantitytype2logs: NSSet?

}

// MARK: Generated accessors for quantitytype2logs
extension Quantitytype {

    @objc(addQuantitytype2logsObject:)
    @NSManaged public func addToQuantitytype2logs(_ value: Log)

    @objc(removeQuantitytype2logsObject:)
    @NSManaged public func removeFromQuantitytype2logs(_ value: Log)

    @objc(addQuantitytype2logs:)
    @NSManaged public func addToQuantitytype2logs(_ values: NSSet)

    @objc(removeQuantitytype2logs:)
    @NSManaged public func removeFromQuantitytype2logs(_ values: NSSet)

}

extension Quantitytype : Identifiable {

}
