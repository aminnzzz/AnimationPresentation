//
//  MovableSnakeText.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

struct MovableTextSnakeStyle: View {
    @State private var dragAmount = CGSize.zero
    @State private var isEnabled = false
    @State private var started = false
    @State private var viewSize = CGSize.zero
    let letters = Array("Swift Con")
    var body: some View {
        VStack {
            HStack(spacing: .zero) {
                ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.largeTitle)
                        .background(isEnabled ? .blue : .green)
                        .offset(y: !started ? -viewSize.height / 2 : 0)
                        .offset(dragAmount)
                        .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                        .animation(.bouncy().delay(Double(num) / 20), value: started)
                }
            }
            .onAppear {
                withAnimation {
                    started = true
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { drag in
                        dragAmount = drag.translation
                    }
                    .onEnded { _ in
                        dragAmount = .zero
                        isEnabled.toggle()
                    }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        viewSize = proxy.size
                    }
            }
        )
    }
}

#Preview {
    MovableTextSnakeStyle()
}
