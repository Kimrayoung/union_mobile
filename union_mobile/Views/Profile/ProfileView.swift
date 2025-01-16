//
//  ProfileView.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/15.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @EnvironmentObject private var service: Service
    @StateObject private var viewModel: ProfileViewModel
    @State private var profileImageIndex = 0
    @State var showCloseAlert: Bool = false
    
    init(_ candidateId: Int) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(candidateId))
    }
    
    var body: some View {
        if #available(iOS 16, *) {
            allContent
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        CloseButton(showCloseAlert: $showCloseAlert)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationBackButton()
                    }
                }
        } else {
            allContent
                .navigationBarItems(trailing: CloseButton(showCloseAlert: $showCloseAlert))
                .navigationBarItems(leading: NavigationBackButton())
        }
    }
    
    @MainActor
    var allContent: some View {
        VStack(spacing: 0) {
            ScrollView {
                if !viewModel.profileData.sortedProfilInfoList.isEmpty {
                    profileImageTabView
                    profileInfo
                    copyrightView
                } else {
                    ProgressView()
                        .frame(maxHeight: .infinity)
                }
            }
            VoteButton(height: 48, buttonAction: { try await viewModel.voteCandidate() }, voteComplete: viewModel.profileData.voted, needIcon: viewModel.profileData.voted)
                .padding(.horizontal, 16)
        }
        .overlay(content: {
            if viewModel.showErrorAlert {
                errorAlert
            }
            if viewModel.showCompletedAlert {
                voteCompleteAlert
            }
            if showCloseAlert {
                CloseAlert(showCloseAlert: $showCloseAlert)
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("2024 WMU")
        .navigationBarBackButtonHidden(true)
        .background(Color.black)
    }
    
    var profileInfo: some View {
        VStack(spacing: 0) {
            Text(viewModel.profileData.name)
                .font(.kanMedium(22))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top, 26)
                .padding(.bottom, 6)
            Text("Entry No.\(viewModel.profileData.candidateNumber)")
                .font(.kanMedium(14))
                .foregroundStyle(Color.customBlue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.bottom, 26)
            detailInfo
        }
        .padding(.bottom, 26)
        .background(Color.init(hex: "121212"))
    }
    
    @MainActor
    var profileImageTabView: some View {
        TabView(selection: $profileImageIndex) {
            ForEach(0..<viewModel.profileData.sortedProfilInfoList.count, id: \.self) { index in
                ProfileImageView(imageInfo: viewModel.profileData.sortedProfilInfoList[index])
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.darkBlue)
            UIPageControl.appearance().pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        }
        .frame(width: 360, height: 360)
    }
    
    
    var detailInfo: some View {
        VStack(spacing: 0) {
            makeProfile("Education", viewModel.profileData.education, true)
            makeProfile("Major", viewModel.profileData.major, true)
            makeProfile("Hobbies", viewModel.profileData.hobby, true)
            makeProfile("Talent", viewModel.profileData.talent, true)
            makeProfile("Ambition", viewModel.profileData.ambition, false)
        }
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .padding(.vertical, 6)
        .padding(.horizontal, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func makeProfile(_ type: String, _ data: String, _ needDivider: Bool) -> some View {
        return VStack(spacing: 0, content: {
            Text(type)
                .font(.kanMedium(14))
                .foregroundStyle(Color.gray03)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 14)
                .padding(.top, 12)
                .padding(.bottom, 10)
            Text(data)
                .font(.kanRegular(16))
                .foregroundStyle(Color.lightGray4)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 14)
            if needDivider {
                Divider()
                    .frame(height: 0.5)
                    .background(Color.init(hex: "252525"))
                    .padding(.horizontal) // 좌우 여백 추가
            }
        })
        .frame(maxWidth: .infinity)
    }
    
    var copyrightView: some View {
        Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
            .font(.caption)
            .foregroundStyle(Color.white)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color.init(hex: "070909"))
    }
    
    var errorAlert: some View {
        CustomAlert(
            title: "Error",
            message: viewModel.error?.localizedDescription ?? "try again please",
            primaryButtonTitle: "Okay",
            secondaryButtonTitle: nil,
            isPresented: $viewModel.showErrorAlert,
            primaryAction: nil,
            secondaryAction: nil
        )
    }
    
    var voteCompleteAlert: some View {
        CustomAlert(
            title: "Voting completed",
            message: "Thank you for voting",
            primaryButtonTitle: "Confirm",
            secondaryButtonTitle: nil,
            isPresented: $viewModel.showCompletedAlert,
            primaryAction: nil,
            secondaryAction: nil
        )
    }
}

#Preview {
    ProfileView(3)
}

//CandidateDetail(id: 1, candidateNumber: 1, name: "Gana", country: "KH", education: "Gana University", major: "Computer Science", hobby: "Playing Soccer", talent: "dance", ambition: "I want to be a great Android developer", contents: "I'm Gana! please vote me", profileInfoList: [ProfileInfoList(fileArea: 1, displayOrder: 0, profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/48/b8669d9579154dd787207dc1226c6e0f.gif", mimeType: "image/gif"), ProfileInfoList(fileArea: 2, displayOrder: 0, profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/55/86e7bff131984cb5a922bc175652d93a.gif", mimeType: "image/gif"), ProfileInfoList(fileArea: 2, displayOrder: 1, profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/55/89bf5e2a94274b7dae61140a765512c9.gif", mimeType: "image/gif"), ProfileInfoList(fileArea: 2, displayOrder: 2, profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/55/4430ae1c5c9c4d04ab84c4df4389be2b.gif", mimeType: "image/gif")], regDt: "2025-01-09 23:23:59", voted: false)
