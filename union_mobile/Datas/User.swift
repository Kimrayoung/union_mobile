//
//  User.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import Foundation

struct User {
    var id: String
}

extension User {
    static func create(_ id: String) -> User {
        return User(id: id)
    }
}
