//
//  EarthImageView.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import SwiftUI

struct EarthImageView: View {
    var body: some View {
        Image("earth")
            .resizable()
            .frame(height: 96)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    EarthImageView()
}
