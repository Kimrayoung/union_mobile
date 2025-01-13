//
//  VoteView.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import SwiftUI

struct VoteView: View {
    @StateObject private var viewModel = VoteViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                QueenImageView()
                timeStack
                EarthImageView()
                voteInformation
                candidateView
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("2024 WMU")
        .background(
            Color.black
        )
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
    }
    
    var timeStack: some View {
        HStack(spacing: 18) {
            TimeCard(value: viewModel.timeRemaining.days, unit: "DAY", needColon: true)
            TimeCard(value: viewModel.timeRemaining.hours, unit: "HR", needColon: true)
            TimeCard(value: viewModel.timeRemaining.minutes, unit: "MIN", needColon: true)
            TimeCard(value: viewModel.timeRemaining.seconds, unit: "SEC", needColon: false)
        }
    }
    
    var voteInformation: some View {
        VStack {
            Text("WORLD MISS UNIVERSITY")
                .font(.kanRegular(14))
                .foregroundStyle(Color.customBlue)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Mobile Voting \nInformation")
                .font(.kanSemiBold(28))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("2024 World Miss University brings\ntogether future global leaders who embody both \nbeauty and intellect.")
                .font(.kanRegular(14))
                .foregroundStyle(Color.gray02)
                .frame(maxWidth: .infinity, alignment: .leading)
            voteInformationDescription
        }
        .padding(.vertical, 50)
        .padding(.horizontal, 16)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "060203"),
                    Color(hex: "1C1C1C")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        
    }
    
    var voteInformationDescription: some View {
        VStack {
            votePeriod
            Divider()
            howToVote
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .padding(.top, 30)
    }
    
    var votePeriod: some View {
        HStack(spacing: 16) {
            Text("period")
                .font(.kanMedium(13))
                .foregroundStyle(Color.white)
                .frame(width: 77, alignment: .leading)
            Text("10/17(Thu) 12PM - 10/31(Thu) 6PM")
                .font(.kanRegular(13))
                .foregroundStyle(Color.white)
        }
        .frame(height: 43)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var howToVote: some View {
        HStack(spacing: 16) {
            Text("How To Vote")
                .font(.kanMedium(13))
                .foregroundStyle(Color.white)
                .frame(width: 77, alignment: .leading)
                .frame(maxHeight: .infinity, alignment: .topLeading)
            VStack(spacing: 10) {
                Text("• Up to three people can participate in early voting per day.")
                    .font(.kanRegular(13))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("• Three new voting tickets are issued every day at midnight(00:00), and you can vote anew every day during the early voting period")
                    .font(.kanRegular(13))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    var candidateView: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundStyle(Color.customBlue)
                .frame(width: 19.41, height: 3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            Text("2024\nCandidate List")
                .font(.kanSemiBold(28))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 25)
            Text("※ You can vote for up to 3 candidates")
                .foregroundStyle(Color.gray02)
                .font(.kanRegular(14))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 50)
        .padding(.horizontal, 16)
    }
    
//    var candidateList: some View {
//        LazyVGrid(columns: columns, spacing: 16) {
//            ForEach(viewModel) { candidate in
//                CandidateCard(candidate: candidate)
//            }
//        }
//        .padding()
//    }

}

#Preview {
    VoteView()
}
