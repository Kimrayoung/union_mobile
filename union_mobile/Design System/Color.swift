//
//  Color.swift
//  union_mobile
//
//  Created by 김라영 on 2025/01/12.
//

import SwiftUI

extension Color {
    /// 4232D5
    static var darkBlue: Color {
        return Color(hex: "4232D5")
    }
    
    /// 6F76FF
    static var customBlue: Color {
        return Color(hex: "6F76FF")
    }
    
    /// DBDBDB
    static var lightGray: Color {
        return Color(hex: "DBDBDB")
    }
    
    /// DADADA
    static var lightGray2: Color {
        return Color(hex: "DADADA")
    }
    
    /// B9B9B9
    static var customGray: Color {
        return Color(hex: "B9B9B9")
    }
    
    /// AEAEB2
    static var gray02: Color {
        return Color(hex: "AEAEB2")
    }
    
    /// D9D9D9
    static var lightGray3: Color {
        return Color(hex: "D9D9D9")
    }
    
    /// F6F6F6
    static var lightGray4: Color {
        return Color(hex: "F6F6F6")
    }
    
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
