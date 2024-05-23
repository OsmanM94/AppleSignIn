//
//  AppleButtonView.swift
//  AppleSignIn
//
//  Created by Osman M. on 22/05/2024.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    
    @EnvironmentObject private var viewModel: CloudKitViewModel
    
    @State private var isActive: Bool = false
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            if isActive {
                TitleView(titleName: "Sign in")
                
                Spacer(minLength: 0)
                
                DisplayView()
                
                Spacer(minLength: 0)
                
                SignInWithAppleButton(.signIn) { request in
                    viewModel.handleAuthorizationAppleIDRequest(request: request)
                } onCompletion: { result in
                    viewModel.handleAuthorizationAppleIDCompletion(result: result)
                }
                .frame(maxWidth: .infinity, maxHeight: 55)
                .signInWithAppleButtonStyle(.white)
                .padding()
                
            } else {
                LoadingView(isAnimating: $isAnimating)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation (.easeInOut(duration: 1.0)) {
                    isActive = true
                    isAnimating = false
                }
            }
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(CloudKitViewModel())
}
