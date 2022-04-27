//
//  Category.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable {
    
    case donation
    case food
    case entertainment
    case health
    case shopping
    case transportation
    case utilities
    case other
    
    var systemNameIcon: String {
        switch self {
        case .donation: return "heart.circle.fill"
        case .food: return "archivebox"
        case .entertainment: return "tv.music.note"
        case .health: return "staroflife"
        case .shopping: return "cart"
        case .transportation: return "car"
        case .utilities: return "bolt"
        case .other: return "tag"
        }
    }
    
    var color: Color {
        switch self {
        case .donation: return Color(hexString: "DB69A9")
        case .food: return Color(hexString: "3C8BE0")
        case .entertainment: return Color(hexString: "B73350")
        case .health: return Color(hexString: "E0A73C")
        case .shopping: return Color(hexString: "E8DE5F")
        case .transportation: return Color(hexString: "42DD76")
        case .utilities: return Color(hexString: "3BD0DD")
        case .other: return Color(hexString: "A057E0")
        }
    }
}


extension Category: Identifiable {
    var id: String { rawValue }
}
