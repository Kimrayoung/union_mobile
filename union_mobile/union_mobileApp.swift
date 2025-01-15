//
//  union_mobileApp.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/12.
//

import SwiftUI

@main
struct union_mobileApp: App {
    @StateObject private var service = Service.shared
    
    var body: some Scene {
        WindowGroup {
            DefaultView()
                .environmentObject(service)
                .preferredColorScheme(.light)
        }
    }
}
