//
//  ButtonAnimations.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

struct SpinningArcButtonStyle: ButtonStyle {
    @State private var animation = 0.0

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .clipShape(Circle())
            .foregroundStyle(.white)
            .padding(4)
            .overlay {
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.blue, lineWidth: 4)
                    .rotationEffect(.degrees(360 * -animation))
            }
            .padding(6)
            .overlay {
                Circle()
                    .trim(from: 0.5, to: 1)
                    .stroke(Color.blue, lineWidth: 4)
                    .rotationEffect(.degrees(360 * animation))
            }
            .onAppear {
                withMotionAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                    animation = 1
                }
            }
    }
}

struct PulsingButtonStyle: ButtonStyle {
    @State private var animation = 0.0
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .clipShape(Circle())
            .foregroundColor(.white)
            .padding(4)
            .overlay {
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .scaleEffect(0.4 + animation)
                    .opacity(1 - animation)
            }
            .onAppear {
                withMotionAnimation(.easeOut(duration: 1.5).repeatForever(autoreverses: false)) {
                    animation = 1
                }
            }
    }
}

struct ButtonPulseAnimation: View {
    var body: some View {
        VStack {
            Button {
                print("pressed")
            } label: {
                Image(systemName: "star")
            }
            .buttonStyle(PulsingButtonStyle())
            Button {
                print("pressed")
            } label: {
                Image(systemName: "star")
            }
            .buttonStyle(SpinningArcButtonStyle())
        }
    }
}

#Preview {
    ButtonPulseAnimation()
}
