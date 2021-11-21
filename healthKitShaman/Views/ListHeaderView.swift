//
//  ListHeaderView.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 09.10.21.
//

import SwiftUI

struct ListHeaderView: View {
    @State var text: String 
    @State var alignement: Alignment
    @State var font: Font
    @State var foreGroundColor: Color
    @State var lineLimit = 1
    
    var body: some View {
        Text(text)
            .frame(width: textWidth, alignment: alignement)
            .lineLimit(lineLimit)
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
        ListHeaderView(text: "ListHeaderText_1", alignement: .leading, font: .headline, foreGroundColor: .black)
        ListHeaderView(text: "ListHeaderText_2", alignement: .leading, font: .headline, foreGroundColor: .black)
        }
    }
}
