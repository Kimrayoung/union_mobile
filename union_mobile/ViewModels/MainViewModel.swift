//
//  MainViewModel.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/14.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    private let service = Service.shared
    @Published var userId: String = ""
    @Published var showErrorAlert: Bool = false
    @Published var isNavigatingToVote: Bool = false
    
    func storeUserId(_ userId: String) {
        if self.userId == "" {
            showErrorAlert = true
        } else {
            print(#fileID, #function, #line, "- self.userId: \(self.userId)")
            service.myUserModel = User.create(self.userId)
            if #available(iOS 16, *) {
                self.service.path.append(.vote)
            } else {
                self.isNavigatingToVote = true
            }
        }
        
    }
}
