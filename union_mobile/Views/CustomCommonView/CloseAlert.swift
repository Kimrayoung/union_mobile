//
//  CloseAlert.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/16.
//

import SwiftUI

/// 앱 종료할 건지 물어보는 얼럿
struct CloseAlert: View {
    @Binding var showCloseAlert: Bool
    var body: some View {
        CustomAlert(
            title: "Check", 
            message: "Are You Really Close App?",
            primaryButtonTitle: "Yes",
            secondaryButtonTitle: "No",
            isPresented: $showCloseAlert,
            primaryAction: { gracefulExit() },
            secondaryAction: nil
        )
    }
    
    /// 앱 종료 로직
    func gracefulExit() {
        //네트워크 연결 종료
        URLSession.shared.invalidateAndCancel()
        // 앱종료
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            exit(0)
        }
    }
}

#Preview {
    CloseAlert(showCloseAlert: .constant(false))
}
