//
//  VoteButton.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import SwiftUI

struct VoteButton: View {
    let height: CGFloat
    let buttonAction: (() -> Void)
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Text("Vote")
                .foregroundStyle(Color.white)
                .font(.kanBold(16))
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .background(Color.darkBlue)
                .clipShape(RoundedRectangle(cornerRadius: 999))
                .padding(.top, 10)
        }
    }
}

#Preview {
    VoteButton(height: 32, buttonAction: { print(#fileID, #function, #line, "- vote button tap") })
}
