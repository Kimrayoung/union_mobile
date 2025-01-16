//
//  TimeCard.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import SwiftUI

/// 타이머 카드
struct TimeCard: View {
    let value: Int
    let unit: String
    let needColon: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text("\(value)")
                .font(.kanMedium(22))
                .foregroundStyle(Color.lightGray2)
                .frame(width: 48, height: 48)
                .background(Color.white.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay(alignment: .trailing) {
                    if needColon {
                        Text(":")
                            .foregroundStyle(Color.lightGray3)
                            .offset(x: 11.5) // 콜론의 위치를 조절
                    }
                }
            
            Text(unit)
                .font(.kanMedium(10))
                .foregroundStyle(Color.customGray)
        }
        .background(Color.black)
    }
}

#Preview {
    TimeCard(value: 3, unit: "hour", needColon: true)
}
