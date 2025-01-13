//
//  queenImageView.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import SwiftUI

struct QueenImageView: View {
    var body: some View {
        Image("queen")
            .resizable()
            .frame(height: 374)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 32)
            .padding(.top, 22)
    }
}

#Preview {
    QueenImageView()
}
