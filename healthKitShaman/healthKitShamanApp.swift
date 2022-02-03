//
//  healthKitShamanApp.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 07.06.21.
//

import SwiftUI

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
        			
    }
}

