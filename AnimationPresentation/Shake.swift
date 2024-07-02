//
//  Shake.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

struct Shake: ViewModifier, Animatable {
    var numberOfShakes: Double
    var animatableData: Double {
        get { numberOfShakes }
        set { numberOfShakes = newValue }
    }
    func body(content: Content) -> some View {
        content
            .offset(x: -sin(numberOfShakes * 2 * .pi) * 30)
    }
}

struct ShakeDemo: View {
    @State private var shakes = 0
    var body: some View {
        Button("Shake!") { shakes += 1 }
            .modifier(Shake(numberOfShakes: Double(shakes)))
            .animation(.default, value: shakes)
    }
}

#Preview {
    ShakeDemo()
}
