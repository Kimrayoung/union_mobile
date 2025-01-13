//
//  CandidateCard.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import SwiftUI
import Kingfisher

struct CandidateCard: View {
    let candidate: Candidate
    var body: some View {
        VStack(spacing: 0) {
            KFImage(URL(string: candidate.profileUrl))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFit()
                .frame(width: 156, height: 156)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.bottom, 18)
            Text(candidate.name)
                .font(.kanMedium(16))
                .foregroundStyle(Color.lightGray4)
                .padding(.bottom, 4)
            Text("\(candidate.voteCnt) voted")
                .foregroundStyle(Color.customBlue)
                .font(.kanMedium(14))
            VoteButton(height: 32, buttonAction: {})
        }
        .frame(width: 156, height: 255)
        .background(Color.black)
    }
}

#Preview {
    CandidateCard(candidate: Candidate(id: 55, cadidateNumber: 5, name: "Jara", profileUrl: "https://angkorchat-bucket.s3.ap-southeast-1.amazonaws.com/candidate/55/b01b482bc1ab420db631f8b92affbebe.png", voteCnt: "6"))
}
