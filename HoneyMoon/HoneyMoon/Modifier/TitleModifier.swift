//
//  TitleModifier.swift
//  HoneyMoon
//
//  Created by GeoSpark on 24/01/22.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.pink)
    }
}

