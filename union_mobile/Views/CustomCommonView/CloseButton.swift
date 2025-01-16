//
//  CloseButton.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/16.
//

import SwiftUI

struct CloseButton: View {
    @Binding var showCloseAlert: Bool
    var body: some View {
        Button {
            showCloseAlert = true
        } label: {
            Image("close")
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}
