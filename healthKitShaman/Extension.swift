//
//  Extension.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 30.09.21.
//

import Foundation
import CoreData
import SwiftUI
import Combine


extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
extension Binding where Value == NSNumber {
    static func bindFromNSNumber(detailObject: NSManagedObject, key: String) -> Binding<NSNumber> {
        return Binding(
            get: {
                if detailObject.value(forKey: key) != nil {
                    return detailObject.value(forKey: key) as! NSNumber
                } else {
                    return 0 
                }
            },
            set: {
                detailObject.setValue($0, forKey: key)
            })
    }
}
extension Binding where Value == String {
    static func bindingFromString(detailObject: NSManagedObject, key: String) -> Binding<String> {
        return Binding(
            get: {
                "\(detailObject.value(forKey: key) ?? "")"
            },
            set: {
                detailObject.setValue($0, forKey: key)
        })
    }
    var optionalBinding: Binding<String> {
            .init(
                get: {
                    self.wrappedValue
                }, set: {
                    self.wrappedValue = $0
                }
            )
        }
}
extension Binding where Value == NSNumber {
    func bindingFromString(detailObject: [NSManagedObject], key: String, index: Int) -> Binding<NSNumber> {
        return Binding(
            get: {
                detailObject[index].value(forKey: key) as! NSNumber
                
            },
            set: {
                detailObject[index].setValue("\($0)", forKey: key)
        })
    }
    var optionalBinding: Binding<NSNumber> {
            .init(
                get: {
                    self.wrappedValue
                }, set: {
                    self.wrappedValue = $0
                }
            )
        }
}
func valueChanged(to value: Any) {
    print("Name changed to \(value)!")
}
extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}


extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    func systemLabelStyle() -> some View {
        modifier(SystemLabel())
    }
    func userLabelStyle() -> some View {
        modifier(UserLabel())
    }
    func fillScreenStyle() -> some View {
        modifier(FillScreen())
    }
    func systemTextLabelStyle() -> some View {
        modifier(SystemTextLabel())
    }
    func systemTextContentStyle() -> some View {
        modifier(SystemTextContent())
    }
    func userTextFieldStyle() -> some View {
        modifier(UserTextFieldContent())
    }
    func disclosureGroupStyle() -> some View {
        modifier(DisclosureGroupStyle())
    }
    func disclosureElementStyle() -> some View {
        modifier(DisclosureElementStyle())
    }
}
extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}
