//
//  CategoryRowView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct CategoryRowView: View {
    @EnvironmentObject var currency: CurrencySettings

    let category: Category
    let sum: Double
    
    var body: some View {
        VStack {
            CategoryImageView(category: category)
            Text((sum * Double(currency.rate)).formattedCurrencyText).font(Font.custom("GT", size: 20))
            Spacer()
            Text(category.rawValue.capitalized).font(Font.custom("Canela-Light", size: 18))
        }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(category: .donation, sum: 2500)
    }
}
