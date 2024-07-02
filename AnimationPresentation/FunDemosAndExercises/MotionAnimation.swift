//
//  MotionAnimation.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

import SwiftUI

public func withMotionAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

/**
 Use this function when you want to disable animation in a specific instance
 example is the view below
 */
public func withoutAnimation<Result>(_ body: () throws -> Result) rethrows -> Result {
    var transaction = Transaction()
    transaction.disablesAnimations = true
    return try withTransaction(transaction, body)
}

public func withHighPriorityAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    var transaction = Transaction(animation: animation)
    transaction.disablesAnimations = true
    return try withTransaction(transaction, body)
}

public struct MotionAnimationModifier<V: Equatable>: ViewModifier {
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion

    let animation: Animation?
    let value: V

    public func body(content: Content) -> some View {
        if accessibilityReduceMotion {
            content
        } else {
            content.animation(animation, value: value)
        }
    }
}

extension View {
    func motionAnimtion<V: Equatable>(_ animation: Animation?, value: V) -> some View {
        self.modifier(MotionAnimationModifier(animation: animation, value: value))
    }
}

struct MotionAnimation: View {
    @State private var scale1 = 1.0
    @State private var scale2 = 1.0
    var body: some View {
        VStack {
            Button("scale") {
                withoutAnimation {
                    scale1 += 1
                }
            }
            .scaleEffect(scale1)
            .animation(.default, value: scale1)

            Button("scale") {
                withHighPriorityAnimation(.linear(duration: 3)) {
                    scale2 += 1
                }
            }
            .scaleEffect(scale2)
            .animation(.default, value: scale2)
        }
    }
}

#Preview {
    MotionAnimation()
}
