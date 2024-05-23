//
//  MonitorView.swift
//  AppleSignIn
//
//  Created by Osman M. on 23/05/2024.
//

import SwiftUI

struct DisplayView: View {
    
    @State private var showSignInGuidance: Bool = false
    
    var body: some View {
        ZStack {
            Image(systemName: "display")
                .font(.system(size: 300, weight: .ultraLight))
            
            if showSignInGuidance {
                HStack(spacing: 8) {
                    Image(systemName: "apple.logo")
                        .font(.system(size: 12))
                        .imageScale(.large)
                    
                    Text("Sign in with Apple to continue.")
                        .font(.callout)
                        .bold()
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showSignInGuidance.toggle()
                }
            }
        }
    }
}

#Preview {
    DisplayView()
}
