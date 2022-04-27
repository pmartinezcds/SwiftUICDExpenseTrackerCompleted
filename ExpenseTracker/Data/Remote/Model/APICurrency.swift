//
//  APICurrency.swift
//  ExpenseTracker
//
//  Created by Paula  Martinez on 27/4/22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation
import UIKit

struct APICurrency: Codable {
    let amount: Double
    let to_currency: String
    let from_currency: String
}
