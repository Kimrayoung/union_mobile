//
//  VoteNetwork.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import Foundation

class VoteNetworkService {
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    /// 후보자 리스트 불러오기
    /// - Parameter sortType: 후보자 리스트 정렬방법(기본: string)
    /// - Returns: 후보자 리스트
    func fetchCadidateList(_ sortType: String = "string") async throws -> Result<PageCandidateList, Error> {
        return await networkManager.callWithAsync(endpoint: VoteAPIManager.fetchCandidateList(sortType: sortType), httpCodes: .success)
    }
    
    /// 해당 유저가 투표한 후보자 리스트
    /// - Parameter userId: 유저 ID
    /// - Returns: 투표한 후보자 id 리스트
    func fetchVoteCandidateList(_ userId: String) async throws -> Result<[Int], Error> {
        return await networkManager.callWithAsync(endpoint: VoteAPIManager.fetchVoteCandidateList(userId: userId), httpCodes: .success)
    }
    
    /// 후보자한테 투표
    /// - Parameter vote: 투표 데이터(userID, 후보자ID)
    /// - Returns: <#description#>
    func voteCandidate(_ vote: Vote) async throws -> Result<EmptyResponse, Error> {
        return await networkManager.callWithAsync(endpoint: VoteAPIManager.voteCandidate(vote: vote), httpCodes: .success)
    }
    
    /// 후보자 정보 가지고 오기 + 유저가 해당 후보자에게 투표했는지 확인
    /// - Parameter vote: 투표 데이터(유저 아이디, 후보자 아이디)
    /// - Returns: 후보자 상세정보
    func candidateDetailAndCheckVote(_ vote: Vote) async throws -> Result<CandidateDetail, Error> {
        return await networkManager.callWithAsync(endpoint: VoteAPIManager.candidateDetail(vote: vote), httpCodes: .success)
    }
}

enum VoteAPIManager {
    case fetchCandidateList(sortType: String)
    case fetchVoteCandidateList(userId: String)
    case voteCandidate(vote: Vote)
    case candidateDetail(vote: Vote)
}

extension VoteAPIManager: APIManager {
    var path: String {
        switch self {
        case .fetchCandidateList(let sortType):
            return "/vote/candidate/list?page=0&size=20&sort=\(sortType)"
        case .fetchVoteCandidateList(let userId):
            return "/vote/voted/candidate/list?userId=\(userId)"
        case .voteCandidate:
            return "/vote"
        case .candidateDetail(let vote):
            return "/vote/candidate/\(vote.id)?userId=\(vote.userId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchCandidateList, .fetchVoteCandidateList, .candidateDetail: return .get
        case .voteCandidate: return .post
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchCandidateList, .fetchVoteCandidateList, .voteCandidate, .candidateDetail:
            return ["Content-Type": "application/json"]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .fetchCandidateList, .fetchVoteCandidateList, .candidateDetail: return nil
        case let .voteCandidate(vote):
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(vote)
            return jsonData
        }
    }
    
    
}
