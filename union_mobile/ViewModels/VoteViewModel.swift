//
//  VoteViewModel.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import Foundation
import Combine

@MainActor
class VoteViewModel: ObservableObject {
    //MARK: - Properties
    private let service = Service.shared
    private let voteNetwork = VoteNetworkService()
    private var cancellables = Set<AnyCancellable>()
    /// 남은 시간
    @Published private(set) var timeRemaining: CountDownTimeComponent = CountDownTimeComponent(totalSeconds: 0)
    private let targetDate: Date
    
    @Published private(set) var candidateList: [Candidate] = []
    private(set) var votedCandidateList: [Int] = []
    
    @Published private(set) var error: Error?
    @Published var showErrorAlert: Bool = false
    @Published var showCompletedAlert: Bool = false
    
    //MARK: - Init
    init() {
        let calendar = Calendar.current
        var components = DateComponents()
        
        components.year = 2025
        components.month = 2
        components.day = 3
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        self.targetDate = calendar.date(from: components) ?? Date()
        setupTimer()
        
    }
    
    //MARK: - 카운트다운 관련 함수들
    /// 타이머 셋팅
    private func setupTimer() {
        // 1초마다 이벤트 발생, 메인 스레드에서 실행, 일반적인 런루프 모드
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect() // 퍼블리셔 자동 구독 상태로
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.calculateTimerRemaining()
            }
            .store(in: &cancellables)
    }
    
    /// 남은 시간 계산(카운트 다운)
    private func calculateTimerRemaining() {
        // timeInvervalSinceNow -> 현재 시점으로부터 특정 날짜까지의 시간 차이를 초(seconds) 단위로 반환
        let remaining = targetDate.timeIntervalSinceNow
        timeRemaining = CountDownTimeComponent(totalSeconds: max(0, remaining))
    }
    
    //MARK: - API 호출
    @MainActor
    /// 후보자 리스트 불러오기
    /// - Parameter sortType: 후보자 리스트 정렬 기준
    func fetchCandidateList(_ sortType: String = "string") async {
        do {
            let result = try await voteNetwork.fetchCadidateList()
            
            switch result {
            case .success(let pageCandidateList):
                self.candidateList = pageCandidateList.content
            case .failure(let error):
                self.error = error
                self.showErrorAlert = true
            }
        } catch {
            self.error = error
            self.showErrorAlert = true
        }
    }
    
    @MainActor
    /// 해당 유저가 투표한 후보자 ID리스트 불러오기
    func fetchUserVotedCandidateList() async {
        do {
            let result = try await voteNetwork.fetchVoteCandidateList(service.myUserModel.id)
            
            switch result {
            case .success(let data):
                self.votedCandidateList = data
            case .failure(let error):
//                print(#fileID, #function, #line, "- error:\(error.localizedDescription)")
                self.error = error
                self.showErrorAlert = true
            }
        } catch {
            self.error = error
            self.showErrorAlert = true
        }
    }
    
    func checkVotedCandidate() {
        let tempCandidateList = candidateList.map { candidate in
            var newCandidate = candidate
            newCandidate.voted = self.votedCandidateList.contains(candidate.id)
            return newCandidate
        }
        
        self.candidateList = tempCandidateList
//        print(#fileID, #function, #line, "- calling☘️")
    }
    
    /// 후보자한테 투표
    /// - Parameter candidateId: 투표할 후보자 아이디
    func voteCandidate(_ candidateId: Int) async throws {
        let vote = Vote(userId: service.myUserModel.id, id: candidateId)
        do {
            let result = try await voteNetwork.voteCandidate(vote)
            
            switch result {
            case .success(_):
                votedCandidateList.append(candidateId)
                checkVotedCandidate()
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
