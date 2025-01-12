//
//  ContentView.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/12.
//

import SwiftUI

struct MainView: View {
    @State var id: String = ""
    
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
            makeImage("queen")
                .frame(height: 374)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 32)
                .padding(.top, 22)
            idTextField
            loginButton
            Spacer()
            makeImage("earth")
                .frame(height: 96)
                .frame(maxWidth: .infinity)
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("2024 WMU")
        .background(Color.black)
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
    }
    
    
    
    var idTextField: some View {
        Group {
            if #available(iOS 16, *) {
                TextField("Enter your ID", text: $id, prompt: Text("Enter your ID")
                    .font(.kanVariable(13))
                    .foregroundColor(.white.opacity(0.8)))
            } else {
                ZStack(alignment: .leading) {
                    if id.isEmpty {
                        Text("Enter your ID")
                            .font(.kanVariable(13))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    TextField("", text: $id)
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
    
    var loginButton: some View {
        Button {
            print(#fileID, #function, #line, "- hi")
        } label: {
            Text("Log in")
                .foregroundStyle(.white)
                .font(.kanVariable(16))
        }
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .background(Color.darkBlue)
        .clipShape(RoundedRectangle(cornerRadius: 999))
        .padding(.horizontal, 10)
        .padding(.top, 24)
    }
    
    func makeImage(_ image: String) -> some View {
        return Image(image)
            .resizable()
    }
    
}

#Preview {
    MainView()
}


