//
//  ContentView.swift
//  AppleSignIn
//
//  Created by Osman M. on 22/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var viewModel: CloudKitViewModel
    
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isActive {
                    if viewModel.user != nil {
                        ShopView()
                    } else {
                        SignInView()
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundStyle(.red.gradient)
                                .padding(.horizontal)
                        }
                    }
                } else {
                    AppleLogo()
                }
            }
        }
        .onAppear {
            viewModel.checkUserStatus()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation (.easeInOut(duration: 1.0)) {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(CloudKitViewModel())
}


