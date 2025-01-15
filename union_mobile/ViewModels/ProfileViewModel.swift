//
//  ProfileViewModel.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/16.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    //MARK: - Properties
    private let service = Service.shared
    private let voteNetwork = VoteNetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    private(set) var candidateId: Int
    @Published private(set) var profileData: CandidateDetail = CandidateDetail(id: 0, candidateNumber: 0, name: "", country: "", education: "", major: "", hobby: "", talent: "", ambition: "", contents: "", profileInfoList: [], regDt: "", voted: false)
    
    @Published private(set) var error: Error?
    @Published var showErrorAlert: Bool = false
    @Published var showCompletedAlert: Bool = false
    
    init(_ candidateId: Int) {
        self.candidateId = candidateId
        Task {
            try await fetchProfileData()
        }
    }
    
    @MainActor
    func fetchProfileData() async throws {
        let vote = Vote(userId: service.myUserModel.id, id: candidateId)
        print(#fileID, #function, #line, "- voteChecking:\(vote)")
        do {
            let result = try await voteNetwork.candidateDetailAndCheckVote(vote)
            
            switch result {
            case .success(let data):
                profileData = data
            case .failure(let error):
                print(#fileID, #function, #line, "- error:\(error.localizedDescription)")
                self.error = error
                self.showErrorAlert = true
            }
        } catch {
            print(#fileID, #function, #line, "- error:\(error.localizedDescription)")
            self.error = error
            self.showErrorAlert = true
        }
    }
    
    @MainActor
    /// 후보자한테 투표
    /// - Parameter candidateId: 투표할 후보자 아이디
    func voteCandidate() async throws {
        let vote = Vote(userId: service.myUserModel.id, id: self.candidateId)
        do {
            let result = try await voteNetwork.voteCandidate(vote)
            
            switch result {
            case .success(_):
                try await self.fetchProfileData()
                self.showCompletedAlert = true
            case .failure(let error):
                print(#fileID, #function, #line, "- error:\(error)")
                self.error = error
                self.showErrorAlert = true
            }
        } catch {
            print(#fileID, #function, #line, "- error:\(error)")
            self.error = error
            self.showErrorAlert = true
        }
    }
}
