//
//  Font.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/13.
//
import SwiftUI

extension Font {
    /// Kantumry pro 400
    static func kanRegular(_ size: CGFloat) -> Font {
        return Font.custom("KantumruyPro-Regular", size: size)
    }
    
    /// Kantumry pro 500
    static func kanMedium(_ size: CGFloat) -> Font {
        return Font.custom("KantumruyProRoman-Medium", size: size)
    }
    
    /// Kantumry pro 600
    static func kanSemiBold(_ size: CGFloat) -> Font {
        return Font.custom("KantumruyProRoman-SemiBold", size: size)
    }
    
    /// Kantumry pro 700
    static func kanBold(_ size: CGFloat) -> Font {
        return Font.custom("KantumruyProRoman-Bold", size: size)
    }
    
    static func kanItaic(_ size: CGFloat) -> Font {
        return Font.custom("KantumruyPro-Italic", size: size)
    }
}
