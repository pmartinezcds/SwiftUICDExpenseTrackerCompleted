//
//  DashboardTabView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct DashboardTabView: View {
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var totalExpenses: Double?
    @State var categoriesSum: [CategorySum]?
    @State var eur: Bool = false
    @State var buttonText: String = "USD"
    @State private var result: Double = 0
    
    @StateObject var currency = CurrencySettings()
    
    var body: some View {
        ZStack {
            if #available(iOS 14.0, *) {
                Color("ColorPink")
                    .ignoresSafeArea(.all, edges: .all)
            } else {
                // Fallback on earlier versions
            }
            VStack(spacing: 0) {
                VStack(spacing: 4) {
                    HStack {
                        Spacer()
                        Button(self.buttonText) {
                            if !eur {
                                self.eur = true
                                self.buttonText = "EUR"
                                CurrencyApiService().changeCurrency(amount: 1) { (amount) in
                                    if let rate = amount?.rate {
                                        DispatchQueue.main.async {
                                            currency.rate = rate
                                        }
                                    }
                                }
                            } else {
                                self.eur = false
                                self.buttonText = "USD"
                                currency.rate = 1.0
                            }
                        }
                        .background(Color("ColorGreen"))
                        .padding()
                        .foregroundColor(.black)
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    if totalExpenses != nil {
                        Text("Total expenses").font(Font.custom("GT-Ultra", size: 30))
                        if totalExpenses != nil {
                            Text(totalExpenses!.formattedCurrencyText)
                                .font(Font.custom("GT-Ultra", size: 30))
                        }
                    }
                }
                
                if categoriesSum != nil {
                    if totalExpenses != nil && totalExpenses! > 0 {
                        PieChartView(
                            data: categoriesSum!.map { ($0.sum, $0.category.color) },
                            style: Styles.pieChartStyleOne,
                            form: CGSize(width: 300, height: 240),
                            dropShadow: false
                        )
                    }
                 
                    if #available(iOS 14.0, *) {
                        let columns = [
                            GridItem(.adaptive(minimum: 100))
                        ]
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(self.categoriesSum!) { item in
                                    CategoryRowView(category: item.category, sum: item.sum)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(maxHeight: 300)
                    } else {
                        List {
                           Text("Breakdown").font(Font.custom("GT", size: 20))
                           ForEach(self.categoriesSum!) {
                               CategoryRowView(category: $0.category, sum: $0.sum)
                           }
                       }
                    }
               
                }
                
                if totalExpenses == nil && categoriesSum == nil {
                    Text("No expenses data\nPlease add your expenses from the logs tab")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("GT", size: 20))
                        .padding(.horizontal)
                }
            } // VSTACK
            .padding(.top)
            .onAppear(perform: fetchTotalSums)
            .background(Color("ColorPink"))
        } // ZSTACK
        .environmentObject(currency)
    }
    
    func fetchTotalSums() {
        ExpenseLog.fetchAllCategoriesTotalAmountSum(context: self.context) { (results) in
            guard !results.isEmpty else { return }
            
            let totalSum = results.map { $0.sum }.reduce(0, +)
            self.totalExpenses = totalSum
            self.categoriesSum = results.map({ (result) -> CategorySum in
                return CategorySum(sum: result.sum, category: result.category)
            })
        }
    }
    
}


struct CategorySum: Identifiable, Equatable {
    let sum: Double
    let category: Category
    
    var id: String { "\(category)\(sum)" }
}


struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
    }
}
