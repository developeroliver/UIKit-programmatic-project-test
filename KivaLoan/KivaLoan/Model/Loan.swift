//
//  Loan.swift
//  KivaLoan
//
//  Created by olivier geiger on 27/04/2024.
//

import UIKit

struct Loan: Hashable, Codable {
    var name: String = ""
    var country: String = ""
    var use: String = ""
    var amount: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
    }
    
    enum LocationKeys: String, CodingKey {
        case country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let location = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
        country = try location.decode(String.self, forKey: .country)
        use = try container.decode(String.self, forKey: .use)
        amount = try container.decode(Int.self, forKey: .amount)
    }
}

struct LoanDataStore: Codable {
    var loans: [Loan]
}
