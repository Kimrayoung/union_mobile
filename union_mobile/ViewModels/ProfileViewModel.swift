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
    
    /// 후보자 아이디
    private(set) var candidateId: Int
    /// 후보자 프로필
    @Published private(set) var profileData: CandidateDetail = CandidateDetail(id: 0, candidateNumber: 0, name: "", country: "", education: "", major: "", hobby: "", talent: "", ambition: "", contents: "", profileInfoList: [], regDt: "", voted: false)
    
    /// 에러 메시지
    @Published private(set) var error: Error?
    /// 에러 얼럿
    @Published var showErrorAlert: Bool = false
    /// 투표완료 얼럿
    @Published var showCompletedAlert: Bool = false
    
    init(_ candidateId: Int) {
        self.candidateId = candidateId
        Task {
            try await fetchProfileData()
        }
    }
    
    @MainActor
    /// 후보자 프로필 불러오기
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
                self.error = error
                self.showErrorAlert = true
            }
        } catch {
            self.error = error
            self.showErrorAlert = true
        }
    }
}
