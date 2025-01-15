//
//  ContentView.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/12.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var service: Service
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        if #available(iOS 16, *) {
           allContent
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        } else {
            allContent
        }
    }
    
    var allContent: some View {
        VStack {
            QueenImageView()
            idTextField
            loginButton
            Spacer()
            EarthImageView()
        }
        .overlay(content: {
            if viewModel.showErrorAlert {
                idEmptyAlert
            }
        })
        .environmentObject(service)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("2024 WMU")
        .background(Color.black)
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
    }
    
    /// 아이디 입력
    var idTextField: some View {
        Group {
            if #available(iOS 16, *) {
                TextField("Enter your ID", text: $viewModel.userId, prompt: Text("Enter your ID")
                    .font(.kanRegular(13))
                    .foregroundColor(.white.opacity(0.8)))
                .foregroundStyle(Color.white)
            } else {
                ZStack(alignment: .leading) {
                    if viewModel.userId.isEmpty {
                        Text("Enter your ID")
                            .font(.kanRegular(13))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    TextField("", text: $viewModel.userId)
                        .foregroundStyle(Color.white.opacity(0.8))
                }
            }
        }
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .padding(.leading)
        .background(Color.white.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 1)
        )
        .padding(.horizontal, 10)
        .textFieldStyle(PlainTextFieldStyle())
    }
    
    /// 로그인 버튼
    var loginButton: some View {
        Group {
            if #available(iOS 16, *) {
                Button {
                    viewModel.storeUserId(viewModel.userId)
                } label: {
                    loginButtonLabel
                }
            } else {
                Button {
                    viewModel.storeUserId(viewModel.userId)
                } label: {
                    loginButtonLabel
                }
                .background(
                    NavigationLink(destination: VoteView(),
                                   isActive: $viewModel.isNavigatingToVote) {
                        EmptyView()
                    }
                )
            }
        }
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .background(Color.darkBlue)
        .clipShape(RoundedRectangle(cornerRadius: 999))
        .padding(.horizontal, 10)
        .padding(.top, 24)
    }
    
    /// 로그인 버튼 라벨
    private var loginButtonLabel: some View {
        Text("Log in")
            .foregroundStyle(.white)
            .font(.kanBold(16))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    /// userId가 비어져있을 경우 뜨는 alert
    var idEmptyAlert: some View {
        CustomAlert(
            title: "Error",
            message: "Please Enter Your ID",
            primaryButtonTitle: "Okay",
            secondaryButtonTitle: nil,
            isPresented: $viewModel.showErrorAlert,
            primaryAction: nil,
            secondaryAction: nil
        )
    }
    
}

#Preview {
    MainView()
}


