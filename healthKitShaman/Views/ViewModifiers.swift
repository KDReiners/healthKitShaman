//
//  ViewModifiers.swift
//  healthKitShaman
//
//  Created by Klaus-Dieter Reiners on 07.11.21.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
struct SystemLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0,maxWidth: .infinity, alignment: .topLeading)
            .font(.title)
            .foregroundColor(.red)
    }
}
struct UserLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0,maxWidth: .infinity, alignment: .topLeading)
            .font(.title)
            .foregroundColor(.green)
    }
}
struct SystemTextLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
        .opacity(Constants.UI.labelReadOnlyOpacity)
    }
}

struct SystemTextContent: ViewModifier {
    func body(content: Content) -> some View {
        content
            .opacity(Constants.UI.textReadOnlyOpacity)
    }
}
struct UserTextFieldContent: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                    )

    }
}
struct DisclosureGroupStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 0, alignment: .leading)
            .font(.headline)
    }
}
struct DisclosureElementStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 0, alignment: .leading)
            .font(.subheadline)
    }
}
struct FillScreen: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0,maxWidth: .infinity, alignment: .topLeading)
    }
}



