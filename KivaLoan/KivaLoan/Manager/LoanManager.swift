//
//  LoanManager.swift
//  KivaLoan
//
//  Created by olivier geiger on 27/04/2024.
//

import UIKit

class LoanManager {
    static let shared = LoanManager()
    
    var loans = [Loan]()
    private let kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    
    private init() {}
    
    func getLatestLoans(completion: @escaping ([Loan]?) -> Void ) {
        guard let url = URL(string: kivaLoanURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let loanDataStore = try decoder.decode(LoanDataStore.self, from: data)
                self.loans = loanDataStore.loans
                completion(self.loans)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}
