//
//  AnimationVSTransition.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 6/30/24.
//

import SwiftUI

/*
 only one subtree present at the time,
 so the width does not get animated, it belongs to a different subtree
 SwiftUI will think they are two different rects
 this is transition
 */

    /*
     Excersice:


     how do we trick SwiftUI to think they are the same? Or not the same?
     Should we return? ID?

     */




/*

┌────────────────────────────┐
┌────│     ConditionalContent     │────┐
│    └────────────────────────────┘    │
│                                      │
│                                      │
│                                      │
▼                                      ▼
┌────────┐                             ┌─────────┐
│ frame  │                             │  frame  │
└────────┘                             └─────────┘
│                                      │
│                                      │
│                                      │
▼                                      ▼
┌───────────┐                          ┌──────────┐
│   rect    │                          │   rect   │
└───────────┘                          └──────────┘
 */

struct AnimationVSTransition: View {
    @State private var flag = false
    var body: some View {
        let rect = Rectangle()
            .onTapGesture {
                withAnimation { 
                    flag.toggle()
                }
            }

        if flag {
            rect
                .id(1)
                .transition(.opacity)
                .frame(width: 200, height: 100)
        } else {
            rect
                .id(2)
                .transition(.opacity)
                .frame(width: 100, height: 100)
        }
        /*
         not that when views insert or remove from subtree, it is a transition
         */

    }
}

#Preview {
    AnimationVSTransition()
}
