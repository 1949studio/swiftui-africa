//
//  CenterModifier.swift
//  Africa
//
//  Created by Jack Pyo Toke on 16/10/21.
//

import SwiftUI

struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
