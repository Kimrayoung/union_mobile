//
//  VoteViewModel.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//

import Foundation
import Combine

class VoteViewModel: ObservableObject {
    //MARK: - Properties
    /// 남은 시간
    @Published private(set) var timeRemaining: CountDownTimeComponent
    private var cancellables = Set<AnyCancellable>()
    private let targetDate: Date
    
    //MARK: - Init
    init() {
        let calendar = Calendar.current
        var components = DateComponents()
        
        components.year = 2025
        components.month = 2
        components.day = 3
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        self.targetDate = calendar.date(from: components) ?? Date()
        self.timeRemaining = CountDownTimeComponent(totalSeconds: 0)
        setupTimer()
    }
    
    //MARK: - 카운트다운 관련 함수들
    /// 타이머 셋팅
    private func setupTimer() {
        // 1초마다 이벤트 발생, 메인 스레드에서 실행, 일반적인 런루프 모드
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect() // 퍼블리셔 자동 구독 상태로
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.calculateTimerRemaining()
            }
            .store(in: &cancellables)
    }
    
    /// 남은 시간 계산(카운트 다운)
    private func calculateTimerRemaining() {
        // timeInvervalSinceNow -> 현재 시점으로부터 특정 날짜까지의 시간 차이를 초(seconds) 단위로 반환
        let remaining = targetDate.timeIntervalSinceNow
        timeRemaining = CountDownTimeComponent(totalSeconds: max(0, remaining))
    }
    
}
