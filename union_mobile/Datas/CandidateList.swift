//
//  Candidate.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import Foundation

struct PageCandidateList: Codable, Equatable {
    let content: [Candidate]
    let pageable: Pageable?
    let totalPages, totalElements: Int?
    let last: Bool?
    let size, number: Int?
    let sort: Sort?
    let numberOfElements: Int?
    let first, empty: Bool?
}

///참가자
struct Candidate: Codable, Identifiable, Equatable {
    var id: Int
    var candidateNumber: Int
    var name: String
    var profileUrl: String
    var voteCnt: String
    var voted: Bool?
}

// MARK: - Pageable
struct Pageable: Codable, Equatable {
    let sort: Sort?
    let offset, pageNumber, pageSize: Int?
    let paged, unpaged: Bool?
}

// MARK: - Sort
struct Sort: Codable, Equatable {
    let empty, sorted, unsorted: Bool?
}
