//
//  Service.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import Foundation

class Service: ObservableObject {
    static let shared = Service()
    
    @Published var path: [Path] = []
    @Published var myUserModel: User! = nil
    
    init() { }
    
}
