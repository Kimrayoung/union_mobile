//
//  CandidateCard.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import SwiftUI
import Kingfisher

/// 후보자 카드(후보자 리스트에서 사용)
struct CandidateCard: View {
    @EnvironmentObject var service: Service
    @ObservedObject var viewModel: VoteViewModel
    @State private var isNavigatingToProfile: Bool = false
    let candidate: Candidate
    let voted: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            if #available(iOS 16, *) {
                candidateImage
            } else {
                candidateImage
                    .background(
                        NavigationLink(
                            destination: ProfileView(candidate.id),
                            isActive: $isNavigatingToProfile
                        ) {
                            EmptyView()
                        }
                    )
            }
            Text(candidate.name)
                .font(.kanMedium(16))
                .foregroundStyle(Color.lightGray4)
                .padding(.bottom, 4)
            Text("\(candidate.voteCnt) voted")
                .foregroundStyle(Color.customBlue)
                .font(.kanMedium(14))
            VoteButton(height: 32, buttonAction: { try await viewModel.voteCandidate(candidate.id) }, voteComplete: voted, needIcon: false)
        }
        .environmentObject(service)
        .frame(width: 156, height: 255)
        .background(Color.black)
    }
    
    @MainActor
    var candidateImage: some View {
        KFImage(URL(string: candidate.profileUrl))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFit()
            .frame(width: 156, height: 156)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.bottom, 18)
            .onTapGesture {
                if #available(iOS 16, *) {
                    service.path.append(.profile(candidateId: candidate.id))
                } else {
                    self.isNavigatingToProfile = true
                    
                }
            }
    }
}

#Preview {
    CandidateCard(viewModel: VoteViewModel(), candidate: Candidate(id: 55, candidateNumber: 5, name: "Jara", profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/55/b01b482bc1ab420db631f8b92affbebe.png", voteCnt: "6"), voted: false)
}
