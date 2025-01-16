//
//  NavigationBackButton.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/16.
//

import SwiftUI

/// 네비게이션 뒤로가기 버튼(전 화면으로 돌아가기)
struct NavigationBackButton: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var service: Service
    var body: some View {
        Button {
            if #available(iOS 16, *) {
                service.path.removeLast()
            } else {
                dismiss()
            }
        } label: {
            Image("leftArrow")
                .resizable()
                .frame(width: 24, height: 24)
        }
        .environmentObject(service)

    }
}

#Preview {
    NavigationBackButton()
}
