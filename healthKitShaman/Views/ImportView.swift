//
//  ImportView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 14.12.21.
//

import SwiftUI

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
               importXML(path: self.url)
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
func importXML(path: URL) -> Void {
    let dataImporter = HKimporter()
    if let parser = XMLParser(contentsOf: path) {
        parser.delegate = dataImporter
        parser.parse()
    }
}
