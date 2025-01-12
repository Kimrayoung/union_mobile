//
//  Font.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//
import SwiftUI

extension Font {
    static func kanVariable(_ size: CGFloat) -> Font {
        return Font.custom("KantumruyPro-VariableFont_wght", size: size)
    }
    
    static func kanItaic(_ size: CGFloat) -> Font {
        return Font.custom("KantumruyPro-Italic-VariableFont_wght", size: size)
    }
}
