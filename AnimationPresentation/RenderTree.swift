//
//  RenderTree.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 6/30/24.
//

/*
 SwiftUI update happens as a result of a state change
 */

import SwiftUI

struct RenderTree: View {
    @State private var flag = false

    var body: some View {

        // ModifiedContent<ModifiedContent<Rectangle, _FrameLayout>, AddGestureModifier<_EndedGesture<TapGesture>>>

        /*
         1- when we tap, a state change occurs(flag).
         2- the type remains the same as before, with a different width.
         3- state change is wrapped in withAnimation, so any change
         that can be animated, will be animated, and width is one of them
         */

        let x = Rectangle()
            .frame(width: flag ? 100 : 50, height: 50)
            .onTapGesture {
                withAnimation(.linear) {
                    flag.toggle()
                }
                print(type(of: x))
            }

        return x
    }
}

#Preview {
    RenderTree()
}
