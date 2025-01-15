//
//  VoteButton.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import SwiftUI

struct VoteButton: View {
    let height: CGFloat
    let buttonAction: () async throws -> Void
    let voteComplete: Bool
    let needIcon: Bool
    
    var body: some View {
        Button {
            Task {
                try? await buttonAction()
            }
        } label: {
            HStack(spacing: 2) {
                if needIcon {
                    Image("voted")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                Text(voteComplete ? "Voted": "Vote")
                    .foregroundStyle(voteComplete ? Color.darkBlue : Color.white)
                    .font(.kanBold(16))
                    
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(voteComplete ? Color.white : Color.darkBlue)
            .clipShape(RoundedRectangle(cornerRadius: 999))
            .padding(.top, 10)
        }
        
    }
}

#Preview {
    VoteButton(height: 32, buttonAction: { print(#fileID, #function, #line, "- vote button tap") }, voteComplete: false, needIcon: false)
}
