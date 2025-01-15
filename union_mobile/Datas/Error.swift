//
//  Error.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/15.
//

import Foundation

struct APIErrorResponse: Equatable, Codable {
    var errorCode: String
    var errorMessage: String
}
