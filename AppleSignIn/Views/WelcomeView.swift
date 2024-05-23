//
//  Welcome View.swift
//  AppleSignIn
//
//  Created by Osman M. on 22/05/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject private var viewModel: CloudKitViewModel

    @State private var isActive: Bool = false
    @State private var isAnimating: Bool = false
    @State private var isSigningOut: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            if isActive {
                TitleView(titleName: "Shop")
                
                Spacer(minLength: 0)
                
                CardView()
                
                Spacer(minLength: 0)
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isSigningOut = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        viewModel.signOut()
                        isSigningOut = false
                    }
                }) {
                    if isSigningOut {
                        ProgressView()
                    } else {
                        Text("Sign Out")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                    }
                }
                .controlSize(.large)
                .buttonStyle(BorderedButtonStyle())
                .padding(.horizontal)
            }
            else {
                LoadingView(isAnimating: $isAnimating)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation (.easeInOut(duration: 1.0)) {
                    isActive = true
                    isAnimating = false
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(CloudKitViewModel())
}

