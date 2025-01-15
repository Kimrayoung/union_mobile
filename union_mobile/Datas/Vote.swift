//
//  Vote.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/15.
//

import Foundation

struct Vote: Codable {
    let userId: String
    let id: Int
}

// 빈 응답을 위한 구조체 정의
struct EmptyResponse: Codable {
    // 비어있는 구조체
}
