//
//  ImplicitVSExplicit.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

/*
 implicit .animation(value)
 explicit withAnimation {}
 */

struct ImplicitVSExplicit: View {
    @State private var flag = false

/*
 type of v is:
 ModifiedContent<
    ModifiedContent<
        MonodifiedContent<
            Rectangle, _FrameLayout
        >,
    _AnimatiModifier<Bool>>,
AddGestureModifier<_EndedGesture<TapGesture>>
 >
 */

    var body: some View {

        /*

┌────────────────┐
│      tap       │
└────────────────┘
│
▼
┌────────────────┐
│   animation    │
└────────────────┘  order matters, but in this instance whether frame is above or                   below, it won't make a difference
│
▼
┌────────────────┐
│     frame      │
└────────────────┘
│
▼
┌────────────────┐
│   rectangle    │
└────────────────┘

         */
        let v = Rectangle()
            .frame(width: flag ? 100 : 50, height: 50)
            .animation(.default, value: flag)
            .onTapGesture {
                flag.toggle()
            }

        /*
         scoping animations, note that only rotation is animated, not th opacity
         */
        let t = Text("Hello World")
            .opacity(flag ? 1 : 0)
            .animation(.default) {
                $0.rotationEffect(flag ? .zero : .degrees(90))
            }

        // Exercise : 
        // Let's add two modifiers to the rectangle, opacity and rotation effect
        // without using scoping like above, only animate the rotation
        // by using the correct order, remember, render tree is from bottom to the top

        let x = Text("Exercise")
            .opacity(flag ? 1 : 0)
            .rotationEffect(flag ? .zero : .degrees(90))

        /*
         we said order matters, but here frame changes, why?
         */
        let f =  Rectangle()
            .animation(.default, value: flag)
            .frame(width: flag ? 100 : 50, height: 50)
            .onTapGesture {
                flag.toggle()
            }


        return VStack {
            v
            t
            f
        }


        /*

         which one to use?
         if the change is coming from server, and a value has changed as a result
         of that server change

         implicit, change of that value will be animated depending on where in the render tree it is,
         explicit, we can scope the change to be animated only in certain parts

         */
    }
}

#Preview {
    ImplicitVSExplicit()
}
