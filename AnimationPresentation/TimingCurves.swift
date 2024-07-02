//
//  TimingCurves.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

/*
 https://cubic-bezier.com/#.29,.58,.83,.67
 */

extension Animation {
    static var edgeBounce: Animation {
        Animation.timingCurve(0, 1, 1, 0)
    }
    static func edgeBounce(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0, 1, 1, 0, duration: duration)
    }

    static var easeInOutBack: Animation {
        Animation.timingCurve(0.7, -0.5, 0.3, 1.5)
    }
    static func easeInOutBack(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0.7, -0.5, 0.3, 1.5, duration: duration)
    }

    static var wrongDirectionFirst: Animation {
        Animation.timingCurve(0.76, -0.46, 0.83, 0.67)
    }
    static func wrongDirectionFirst(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0.76, -0.46, 0.83, 0.67, duration: duration)
    }
}

struct CustomAnimationCurves: View {
    @State private var offset = -200.0
    @State private var scale = 2
    var body: some View {
        VStack {
            HStack {
                Text("Hello, World!")
                    .offset(y: offset)
                    .animation(.edgeBounce(duration: 2).repeatForever(autoreverses: true), value: offset)
                    .onTapGesture {
                        offset = 200
                    }
                Text("Hello, World!")
                    .offset(y: offset)
                    .animation(.easeInOutBack(duration: 2).repeatForever(autoreverses: true), value: offset)
                    .onTapGesture {
                        offset = 200
                    }
            }
            .padding()
            HStack {
                Button("button") {
                    withAnimation(.easeInOutBack(duration: 2).repeatForever(autoreverses: true)) {
                        scale = 1
                    }
                }
                .scaleEffect(CGSize(width: scale, height: scale))
                Spacer()
                Button("button") {
                    withAnimation(.wrongDirectionFirst(duration: 2).repeatForever(autoreverses: true)) {
                        scale = 1
                    }
                }
                .scaleEffect(CGSize(width: scale, height: scale))
            }
            .padding(.horizontal, 50)
        }
    }
}

#Preview {
    CustomAnimationCurves()
}
