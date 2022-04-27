//
//  ExpenseLog+Extension.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

extension ExpenseLog {
    
    var categoryEnum: Category {
        Category(rawValue: category ?? "") ?? .other
    }
    
    var dateText: String {
        Utils.dateFormatter.localizedString(for: date ?? Date(), relativeTo: Date())
    }
    
    var nameText: String {
        name ?? ""
    }
    
    var amountText: String {
        Utils.numberFormatter.string(from: NSNumber(value: amount?.doubleValue ?? 0)) ?? ""
    }
    
    var noteText: String {
        note ?? ""
    }
    
    
    static func fetchAllCategoriesTotalAmountSum(context: NSManagedObjectContext, completion: @escaping ([(sum: Double, category: Category)]) -> ()) {
        let keypathAmount = NSExpression(forKeyPath: \ExpenseLog.amount)
        let expression = NSExpression(forFunction: "sum:", arguments: [keypathAmount])
        
        let sumDesc = NSExpressionDescription()
        sumDesc.expression = expression
        sumDesc.name = "sum"
        sumDesc.expressionResultType = .decimalAttributeType
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ExpenseLog.entity().name ?? "ExpenseLog")
        request.returnsObjectsAsFaults = false
        request.propertiesToGroupBy = ["category"]
        request.propertiesToFetch = [sumDesc, "category"]
        request.resultType = .dictionaryResultType
        
        context.perform {
            do {
                let results = try request.execute()
                let data = results.map { (result) -> (Double, Category)? in
                    guard
                        let resultDict = result as? [String: Any],
                        let amount = resultDict["sum"] as? Double,
                        let categoryKey = resultDict["category"] as? String,
                        let category = Category(rawValue: categoryKey) else {
                            return nil
                    }
                    return (amount, category)
                }.compactMap { $0 }
                completion(data)
            } catch let error as NSError {
                print((error.localizedDescription))
                completion([])
            }
        }
        
    }
    
    static func predicate(with categories: [Category], searchText: String) -> NSPredicate? {
        var predicates = [NSPredicate]()
        
        if !categories.isEmpty {
            let categoriesString = categories.map { $0.rawValue }
            predicates.append(NSPredicate(format: "category IN %@", categoriesString))
        }
        
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "name CONTAINS[cd] %@", searchText.lowercased()))
        }
        
        if predicates.isEmpty {
            return nil
        } else {
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
    }

    static func predicateMonth(with months: [Month]) -> NSPredicate? {
        var predicates = [NSPredicate]()
        let categoriesString = months.map { $0.id}
        
        categoriesString.forEach { month in
            let selectedMonth = month
            let selectedYear = Calendar.current.component(.year, from: Date())
            var components = DateComponents()
            components.month = selectedMonth
            components.year = selectedYear
            let startDateOfMonth = Calendar.current.date(from: components)

            //Now create endDateOfMonth using startDateOfMonth
            components.year = 0
            components.month = 1
            components.day = -1
            let endDateOfMonth = Calendar.current.date(byAdding: components, to: startDateOfMonth!)
            
            predicates.append(NSPredicate(format: "%K >= %@ && %K <= %@", "date", startDateOfMonth! as NSDate, "date", endDateOfMonth! as NSDate))
        }
        
        if predicates.isEmpty {
            return nil
        } else {
            return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        }
    }
    
}

