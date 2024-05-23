//
//  AppleSignInApp.swift
//  AppleSignIn
//
//  Created by Osman M. on 22/05/2024.
//

import SwiftUI

@main
struct AppleSignInApp: App {
    
    @StateObject private var viewModel = CloudKitViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
