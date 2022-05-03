//
//  ImportView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 14.12.21.
//

import SwiftUI
import healthKitPackage

struct ImportView: View {
    @State var filename = "Filename"
    @State var url: URL!
    @State var showFileChooser = false
     var body: some View {
       HStack {
           Text(filename)
           Button("select File")
             {
               let panel = NSOpenPanel()
               panel.allowsMultipleSelection = false
               panel.canChooseDirectories = false
               if panel.runModal() == .OK {
                   self.filename = panel.url?.lastPathComponent ?? "None"
                   self.url = panel.url
               }
             }
           Button("Import") {
               importLibre(path: self.url)
           }
           Button("AttachToAddendum") {
               var test = Libre3TimeCapsules(resolution: 3600)
           }
       }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
     }
}

struct ImportView_Previews: PreviewProvider {
    static var previews: some View {
        ImportView()
    }
}
func importLibre(path: URL) -> Void {
    LibreViewImporter.init(url: path)
}
