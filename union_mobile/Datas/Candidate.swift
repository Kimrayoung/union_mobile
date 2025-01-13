//
//  Candidate.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import Foundation

struct Candidate: Codable, Hashable {
    var id: Int
    var cadidateNumber: Int
    var name: String
    var profileUrl: String
    var voteCnt: String
}

