//
//  Category.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation
import SwiftUI

enum Month: String, CaseIterable {
    
    case january
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december

}


extension Month: Identifiable {
    var id: Int {
        switch self {
        case .january:
           return 1
        case .february:
            return 2
        case .march:
            return 3
        case .april:
            return 4
        case .may:
            return 5
        case .june:
            return 6
        case .july:
            return 7
        case .august:
            return 8
        case .september:
            return 9
        case .october:
            return 10
        case .november:
            return 11
        case .december:
            return 12
        }
    }
}

