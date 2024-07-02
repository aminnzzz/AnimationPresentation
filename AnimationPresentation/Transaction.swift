//
//  Transaction.swift
//  AnimationPresentation
//
//  Created by amin nazemzadeh on 7/1/24.
//

import SwiftUI

/*
 under the hood, implicit or explicit, we use transactions
 which wraps around the animation and has all the animation info
 */

struct TransactionDemo: View {
    @State private var flag = false

    /*
     implicit transactions override explicit ones
     because they get executed while evaluating the view tree
     */

    var body: some View {
        Rectangle()
            .frame(width: flag ? 100 : 50, height: 50)
            .onTapGesture {
                // this is explicit under the hood
                var t = Transaction(animation: .default)
                withTransaction(t) { flag.toggle() }
            }
            .transaction { t in
                // this is implicit under the hood
                t.disablesAnimations = false
                t.animation = .bouncy
            }



        // Exercise, use implicit transactions to get rid of the warning
        let x = Rectangle()
            .onTapGesture {
                flag.toggle()
            }
            .animation(nil) // deprecated, how do we do it with transaction?
    }
}

#Preview {
    TransactionDemo()
}
