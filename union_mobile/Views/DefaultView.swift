//
//  DefaultView.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import SwiftUI

struct DefaultView: View {
    @EnvironmentObject private var service: Service
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(path: $service.path) {
                MainView()  // ZStack 대신 직접 MainView 배치
                    .navigationDestination(for: Path.self) { path in
                        switch path {
                        case .main:
                            MainView()
                        }
                    }
            }
        } else {
            NavigationView {
                MainView()
                    .onAppear {
                        let appearance = UINavigationBarAppearance()
                        appearance.configureWithOpaqueBackground()
                        appearance.backgroundColor = .white
                        
                        // 타이틀 색상 설정 (필요한 경우)
                        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
                        
                        UINavigationBar.appearance().standardAppearance = appearance
                        UINavigationBar.appearance().compactAppearance = appearance
                        UINavigationBar.appearance().scrollEdgeAppearance = appearance
                    }
            }
            .navigationViewStyle(.stack)
        }
        
    }
}

#Preview {
    DefaultView()
}
