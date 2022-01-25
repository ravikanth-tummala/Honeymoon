//
//  CardTransition.swift
//  HoneyMoon
//
//  Created by GeoSpark on 25/01/22.
//

import SwiftUI


extension AnyTransition {
    static var trailingButtom:AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom)))
    }
    
    static var leadingButton:AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom)))
    }
}
