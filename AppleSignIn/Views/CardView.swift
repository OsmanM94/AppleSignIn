//
//  CardView.swift
//  AppleSignIn
//
//  Created by Osman M. on 23/05/2024.
//

import SwiftUI

struct CardView: View {
    
    let images: [String] = ["product4", "product2", "product3", "product1", "product5"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .ignoresSafeArea()
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(images, id: \.self) { image in
                        GroupBox("NEW") {
                            Image(decorative: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 250)
                                .containerRelativeFrame(.horizontal)
                            
                            HStack(spacing: 0) {
                                Text("From £999")
                                    .font(.subheadline)
                                
                                Spacer(minLength: 0)
                                
                                Text("BUY")
                                    .foregroundStyle(.blue)
                                    .fontWeight(.semibold)
                                    .padding(5)
                                    .padding(.horizontal)
                                    .background(Color(.white), in: Capsule())
                            }
                            .padding()
                        }
                        .groupBoxStyle(.cardStyle)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .contentMargins(15)
            .scrollIndicators(.hidden)
        }
        .preferredColorScheme(.dark)
    }
}

struct CardBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .bold()
                .font(.headline)
                .foregroundStyle(.gray)
                .padding()
            configuration.content
                .padding(.bottom)
        }
        .background(.ultraThinMaterial , in: RoundedRectangle(cornerRadius: 12))
    }
}

extension GroupBoxStyle where Self == CardBoxStyle {
    static var cardStyle: CardBoxStyle { .init() }
}

#Preview {
    CardView()
}
