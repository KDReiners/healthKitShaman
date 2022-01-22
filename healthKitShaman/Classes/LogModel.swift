//
//  LogModel.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 19.11.21.
//

import Foundation
class LogModel: Model<Log> {
    @Published var result: [Log]!
    @Published var categories: [Tree<Log>] = []
    @Published var sources = Array<Source>()
    @Published var devices = Array<Device>()
    init() {
        let readOnlyFields = [""]
        super.init(readOnlyFields: readOnlyFields)
    }
    override var items: [Log] {
        get {
            return result
        }
        set
        {
            result = newValue.sorted(by: { $1.timeStamp! > $0.timeStamp! })
            fillCategories(items)
            fillRelations()
        }
    }
    private func fillCategories(_ logs: [Log]) {
        self.categories.removeAll()
        var attachedLogs = [Log]()
        let targetLogs = logs.filter{ log in
            if let hk_quantitytype = log.log2quantitytype?.hk_quantitytype {
                return (hk_quantitytype.contains("Glucose"))
            }
            else {
                return false
            }
        }.sorted { $0.timeStamp! < $1.timeStamp!}
        targetLogs.forEach { log in
            var newTree = Tree(value: log, children: [Tree<Log>]())
            let children = logs.filter { subLog in
                return ( subLog.log2quantitytype?.hk_quantitytype != log.log2quantitytype?.hk_quantitytype
                            && subLog.timeStamp == log.timeStamp! && attachedLogs.contains(subLog) == false)
            }
            attachedLogs.removeAll()
            children.forEach { child in
                attachedLogs.append(child)
                let childTree = Tree( value: child)
                newTree.children?.append(childTree)
            }
            categories.append(newTree)
        }
    }
    private func fillRelations() {
        var attachedSources = Set<Source>()
        var attachedQuantityTypes = Set<Quantitytype>()
        var attachedDevices = Set<Device>()
//        items.forEach { log in
//            print("Log Liste: \(log.uuid?.uuidString ?? "unbekannte uuid")")
//        }
//        print("*******************************")
        items.forEach {log in
//            print("Log Anfang: \(log.uuid?.uuidString ?? "unbekannte uuid")")
            if log.log2source != nil && log.log2quantitytype != nil && log.log2Device != nil {
                attachedSources.insert(log.log2source!)
                attachedQuantityTypes.insert(log.log2quantitytype!)
                attachedDevices.insert(log.log2Device!)
            }
            else {
                print(log)
            }
        }
        self.sources = Array(attachedSources.sorted(by: { $0.hk_name ?? "" < $1.hk_name ?? ""}))
        self.devices = Array(attachedDevices.sorted(by: { $0.hk_name ?? "" < $1.hk_name ?? "" }))
    }
}
