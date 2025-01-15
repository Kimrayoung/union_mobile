//
//  CandidateDetail.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/15.
//

import Foundation

struct CandidateDetail: Codable {
    let id, candidateNumber: Int
    let name, country, education, major: String
    let hobby, talent, ambition, contents: String
    let profileInfoList: [ProfileInfoList]
    let regDt: String
    let voted: Bool
    
    // 정렬된
    var sortedProfilInfoList: [ProfileInfoList] {
//        profileInfoList.sorted { $0.displayOrder < $1.displayOrder }
        profileInfoList.sorted { f, s in
            if f.displayOrder == s.displayOrder {
                return f.fileArea < s.fileArea
            } else { return f.displayOrder < s.displayOrder }
        }
    }
}

// MARK: - ProfileInfoList
struct ProfileInfoList: Codable {
    let fileArea, displayOrder: Int
    let profileUrl: String
    let mimeType: String
}

enum ImageType: String {
    case gif = "image/gif"
    case jpg = "image/jpg"
    case png = "image/png"
}
