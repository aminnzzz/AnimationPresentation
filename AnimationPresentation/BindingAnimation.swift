//
//  BindingAnimation.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

struct ToggleRectangle: View {
    @Binding var flag: Bool
    var body: some View {
        Rectangle()
            .frame(width: flag ? 100 : 50, height: 50)
            .onTapGesture { flag.toggle() }
    }
}

struct BindingAnimation: View {
    @State private var flag = false
    var body: some View {
        /*
         .animation on bindings, wraps the setter of that in an animation

         this way we do not have to rely on the user of the flag to animate it
         */
        ToggleRectangle(flag: $flag.animation(.default))
    }
}

#Preview {
    BindingAnimation()
}
