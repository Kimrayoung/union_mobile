//
//  Service.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import Foundation

class Service: ObservableObject {
    @Published var path: [Path] = []
    @Published var myUserModel: User! = nil
    
    init() { }
    
}
