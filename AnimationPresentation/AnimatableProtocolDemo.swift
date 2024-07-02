//
//  AnimatableProtocolDemo.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

/*
 we tap and flag changes
 traverse down the view tree and see which view or view modifiers conform to animatable
 for those, if the old value of the animatableData is different, interpolate it to the new one baed on the timing curve
 here we use linear with a duration of 1 second, which interpolates from 0.3 to 1 60 times
 */


// this is techinically, the opacity modifier
struct MyOpacity: ViewModifier, Animatable {
    // has to conform to VectorArithmetic
    var animatableData: Double

    init(_ opacity: Double) {
        animatableData = opacity
    }

    func body(content: Content) -> some View {
        let _ = print(animatableData)
        content.opacity(animatableData)
    }
}

struct AnimatableProtocolDemo: View {
    @State private var flag = true
    var body: some View {
        Button("Animate") { flag.toggle() }
            .opacity(flag ? 1 : 0.3)
            //.modifier(MyOpacity(flag ? 1 : 0.3))
            .animation(.linear(duration: 1), value: flag)
    }
}

#Preview {
    AnimatableProtocolDemo()
}
