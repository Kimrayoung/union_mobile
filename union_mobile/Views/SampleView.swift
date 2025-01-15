//
//  SampleView.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/16.
//

import SwiftUI

struct SampleView: View {
    @StateObject private var viewModel: ProfileViewModel
    @State private var profileImageIndex = 0
    
    init(_ candidateId: Int) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(candidateId))
    }
    
    var body: some View {
        Text("Hello, World!\(viewModel.candidateId)")
    }
}

