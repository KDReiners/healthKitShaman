//
//  StartView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 21.12.21.
//

import SwiftUI
import Combine
struct StartView: View {
    @State var subs = Set<AnyCancellable>() // Cancel onDisappear
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.onAppear { trackScrollWheel() }
    }
        
    func trackScrollWheel() {
        NSApp.publisher(for: \.currentEvent)
            .filter { event in event?.type == .rightMouseDragged }
                .throttle(for: .milliseconds(200),
                          scheduler: DispatchQueue.main,
                          latest: true)
                .sink {
                    if let event = $0 {
                        if event.deltaX > 0 { print("right") }
                        if event.deltaX < 0 { print("left") }
                        if event.deltaY > 0 { print("down") }
                        if event.deltaY < 0 { print("up") }
                    }
                }
                .store(in: &subs)
        }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
