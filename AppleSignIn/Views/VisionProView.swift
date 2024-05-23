//
//  VisionProView.swift
//  AppleSignIn
//
//  Created by Osman M. on 22/05/2024.
//

import SwiftUI

struct VisionProView: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        Image(systemName: "visionpro")
            .symbolEffect(.bounce.byLayer, options: .repeat(1).speed(0.8), value: isAnimating)
            .font(.system(size: 250, weight: .ultraLight))
            .foregroundStyle(LinearGradient(colors: [.gray, .gray.opacity(0.5), .gray], startPoint: .top, endPoint: .bottom), EllipticalGradient(colors:[.purple, .black], center: .center, startRadiusFraction: 0.0, endRadiusFraction: 0.50))
            .shadow(color: .black.opacity(0.5), radius: 25, y: 7)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    isAnimating.toggle()
                }
            }
    }
}

#Preview {
    VisionProView()
}
