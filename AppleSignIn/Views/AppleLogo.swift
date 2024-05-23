//
//  AppleLogo.swift
//  AppleSignIn
//
//  Created by Osman M. on 22/05/2024.
//

import SwiftUI

struct AppleLogo: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .ignoresSafeArea()
            Image("apple")
                .resizable()
                .scaledToFit()
        }

    }
}

#Preview {
    AppleLogo()
}
