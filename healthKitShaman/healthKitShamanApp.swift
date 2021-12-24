//
//  healthKitShamanApp.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 07.06.21.
//

import SwiftUI

@main
struct healthKitShamanApp: App {
    
    @ObservedObject var logViewModel = LogModel()
    @ObservedObject var sourceViewModel = SourceModel()
    @ObservedObject var deviceViewModel = DeviceModel()
    @ObservedObject var quantityTypeViewModel = QuantityTypeModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(logViewModel)
                .environmentObject(quantityTypeViewModel)
                .environmentObject(deviceViewModel)
                .environmentObject(sourceViewModel)
            
        }
        .commands {
                    CommandMenu("Create ML") {
                        Button(action: {createMl()}) {
                            Text("Lerne...")
                        }
                    }
            SidebarCommands()
            
        }
    }
    func createMl() -> Void {
        
    }
}
