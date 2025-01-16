//
//  CustomAlert.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import SwiftUI

struct CustomAlert: View {
    let title: String
    let message: String
    let primaryButtonTitle: String
    let secondaryButtonTitle: String?
    let primaryAction: (() -> Void)?
    let secondaryAction: (() -> Void)?
    @Binding var isPresented: Bool
    
    init(
        title: String,
        message: String,
        primaryButtonTitle: String = "확인",
        secondaryButtonTitle: String? = nil,
        isPresented: Binding<Bool>,
        primaryAction: (() -> Void)? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self._isPresented = isPresented
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
    
    var body: some View {
        ZStack {
            // 배경 딤 처리
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                }
            
            // 얼럿 컨텐츠
            VStack(spacing: 0) {
                // 제목
                Text(title)
                    .font(.kanMedium(16))
                    .padding(.top)
                    .padding(.bottom, 20)
                
                // 메시지
                Text(message)
                    .font(.kanRegular(14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                
                Divider()
                // 버튼
                HStack(spacing: 20) {
                    if let secondaryButtonTitle = secondaryButtonTitle {
                        Button(action: {
                            secondaryAction?()
                            isPresented = false
                        }) {
                            Text(secondaryButtonTitle)
                                .font(.kanMedium(16))
                                .foregroundStyle(Color.red)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                                .padding()
                                .cornerRadius(10)
                        }
                    }
                    
                    Button(action: {
                        primaryAction?()
                        isPresented = false
                    }) {
                        Text(primaryButtonTitle)
                            .font(.kanMedium(16))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                            .padding()
                            .foregroundColor(.darkBlue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .frame(height: 48)
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 40)
        }
    }
}
