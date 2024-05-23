//
//  TitleView.swift
//  AppleSignIn
//
//  Created by asia on 23/05/2024.
//

import SwiftUI

struct TitleView: View {
    
    let titleName: String
    
    var body: some View {
        Text(titleName)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 40)
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)

    }
}

#Preview {
    TitleView(titleName: "Welcome back")
}
