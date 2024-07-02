//
//  AnimationCompletionHandler.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

struct AnimationCompletionHandler: View {
    @State private var flag = false

    var body: some View {
        VStack {
            Button("Animate!") { flag.toggle() }
            Circle()
                .fill(flag ? .green : .red)
                .frame(width: 50, height: 50)
                .animation(.default, value: flag)
                .transaction {
                    // dependency tracking happens here
                    // SwiftUI knows this has happened once already,
                    // the fix (value: flag)
                    $0.addAnimationCompletion { print("Done!") }
                }
        }
    }
}

#Preview {
    AnimationCompletionHandler()
}
