//
//  healthKitShamanApp.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 07.06.21.
//

import SwiftUI
import healthKitPackage

@main
struct healthKitShamanApp: App {
    var body: some Scene {
        WindowGroup {
//            StartView().frame(width: 300, height: 400)
            DirectoryView()
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
        Task {
            BaseServices.gatherAllLoggings(resolution: 3600, completion: { (success) -> Void in
                if success {
                    print("all is ready")
                }
            })
        }
        			
    }
}

