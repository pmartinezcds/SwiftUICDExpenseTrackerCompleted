//
//  LogsTabView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct MonthlyTabView: View {
    
    @Environment(\.managedObjectContext)
        var context: NSManagedObjectContext
    
    @State private var searchText : String = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    @State var selectedCategories: Set<Month> = Set()
    @State var isAddFormPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                FilterMonthsView(selectedCategories: $selectedCategories)
                Divider()
                LogListView(predicate: ExpenseLog.predicateMonth(with: Array(selectedCategories)), sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
            }
            .padding(.bottom, searchBarHeight)
            .sheet(isPresented: $isAddFormPresented) {
                LogFormView(context: self.context)
            }
            .navigationBarTitle("Monthly Logs", displayMode: .inline)
        }
    }
    
    func addTapped() {
        isAddFormPresented = true
    }
    
    
    
}

struct MonthlyTabView_Previews: PreviewProvider {
    static var previews: some View {
        LogsTabView()
    }
}
