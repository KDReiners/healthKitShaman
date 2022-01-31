//
//  healthKitShamanApp.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 07.06.21.
//

import SwiftUI

@main
struct healthKitShamanApp: App {
    
//    @ObservedObject var logViewModel = LogModel()
//    @ObservedObject var quantityTypeViewModel = QuantityTypeModel()
//    @ObservedObject var sourceViewModel = SourceModel()
//    @ObservedObject var deviceViewModel = DeviceModel()
    var body: some Scene {
        WindowGroup {
            StartView().frame(width: 300, height: 400)
//            DirectoryView()

//                .environmentObject(logViewModel)
//                .environmentObject(quantityTypeViewModel)
//                .environmentObject(sourceViewModel)
//                .environmentObject(deviceViewModel)
                
            
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
//
//extension healthKitShamanApp {    func trackScrollWheel() {
//    func scrollWheel(with event: NSEvent) {
//        
//    }
//        NSApp.publisher(for: \.currentEvent)
////            .filter { event in event?.type == .leftMouseDown }
////            .throttle(for: .milliseconds(200),
////                      scheduler: DispatchQueue.main,
////                      latest: true)
//            .sink {
//                if let event = $0 {
//                    if event.deltaX > 0 { print("right") }
//                    if event.deltaX < 0 { print("left") }	
//                    if event.deltaY > 0 { print("down") }
//                    if event.deltaY < 0 { print("up") }
//                }
//            }
//    }
//}
