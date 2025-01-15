//
//  ProfileImageView.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/16.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    let imageInfo: ProfileInfoList
    
    var body: some View {
        if imageInfo.mimeType == ImageType.gif.rawValue {
            KFAnimatedImage(URL(string: imageInfo.profileUrl))
                .configure { view in
                    view.framePreloadCount = 3
                }
                .placeholder { ProgressView() }
                .scaledToFit()
        } else {
            KFImage(URL(string: imageInfo.profileUrl))
                .placeholder { ProgressView() }
                .onFailure { error in
                    print(#fileID, #function, #line, "- image error")
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

