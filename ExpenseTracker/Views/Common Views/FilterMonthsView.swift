//
//  FilterCategoriesView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct FilterMonthsView: View {
    
    @Binding var selectedCategories: Set<Month>
    private let categories = Month.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories) { month in
                    FilterMonthButtonView(
                        month: month,
                        isSelected: self.selectedCategories.contains(month),
                        onTap: self.onTap
                    )
                        
                        .padding(.leading, month == self.categories.first ? 16 : 0)
                        .padding(.trailing, month == self.categories.last ? 16 : 0)
                    
                }
            }
        }
        .padding(.vertical)
    }
    
    func onTap(month: Month) {
        if selectedCategories.contains(month) {
            selectedCategories.remove(month)
        } else {
            selectedCategories.insert(month)
        }
    }
}

struct FilterMonthButtonView: View {
    
    var month: Month
    var isSelected: Bool
    var onTap: (Month) -> ()
    
    var body: some View {
        Button(action: {
            self.onTap(self.month)
        }) {
            HStack(spacing: 8) {
                Text(month.rawValue.capitalized)
                    .fixedSize(horizontal: true, vertical: true)
                    .font(Font.custom("GT", size: 20))
                
                if isSelected {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
                
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color(hexString: "DB69A9") : Color(UIColor.lightGray), lineWidth: 1))
                .frame(height: 44)
        }
        .foregroundColor(isSelected ? Color(hexString: "DB69A9") : Color(UIColor.gray))
    }
    
    
}


struct FilterMonthsView_Previews: PreviewProvider {
    static var previews: some View {
        FilterCategoriesView(selectedCategories: .constant(Set()))
    }
}
