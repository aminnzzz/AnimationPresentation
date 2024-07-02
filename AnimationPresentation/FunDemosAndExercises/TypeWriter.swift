//
//  TypeWriter.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

struct Typewriter: View, Animatable {
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion

    private var string: String
    private var count: Int
    init(string: String, count: Int) {
        self.string = string
        self.count = count
    }
    // implement the animatable data
    var animatableData: Double {
        return count
    }

    var body: some View {
        if accessibilityReduceMotion || accessibilityVoiceOverEnabled {
            Text(string)
        } else {
            let stringToShow = String(string.prefix(count))
            ZStack {
                Text(string)
                    .hidden()
                    .overlay(
                        Text(stringToShow),
                        alignment: .topLeading
                    )
            }
        }
    }
}

private struct TypewriterTest: View {
    @State var count = 0
    var text = "Just a long text to show for demonstration purposes"
    var body: some View {
        VStack {
            Typewriter(string: text, count: count)
            Button("update count to count") {
                withAnimation {
                    count = text.count
                }
            }
            Button("update count to zero") {
                withAnimation {
                    count = 0
                }
            }
        }
    }
}

#Preview {
    TypewriterTest()
}
