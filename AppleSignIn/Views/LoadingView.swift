//
//  LoadingView.swift
//  AppleSignIn
//
//  Created by Osman M. on 22/05/2024.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        Image(systemName: "apple.logo")
            .symbolEffect(.pulse.byLayer, options: .repeating.speed(0.8), value: isAnimating)
            .font(.system(size: 60))
            .onAppear {
                isAnimating.toggle()
            }
    }
}

#Preview {
    LoadingView(isAnimating: .constant(false))
}



