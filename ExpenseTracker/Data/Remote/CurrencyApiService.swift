//
//  CurrencyApiService.swift
//  ExpenseTracker
//
//  Created by Paula  Martinez on 27/4/22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation
import UIKit

class CurrencyApiService: NSObject {
    
    func changeCurrency(amount: Double, completion:@escaping (EurCurrency?)-> ()) {
        guard let url = URL(string: "https://elementsofdesign.api.stdlib.com/aavia-currency-converter@dev/") else { return }
        
        let currency = APICurrency(amount: amount, to_currency: "EUR", from_currency: "USD")
        
        guard let uploadData = try? JSONEncoder().encode(currency) else {
            print("Error UploadData: ")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                let code = (error as NSError).code
                print("Error:\(code) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let data = data {
                if let response = try? JSONDecoder().decode(EurCurrency.self, from: data) {
                    completion(response)
                }
            }

        }
        task.resume()
    }
}
