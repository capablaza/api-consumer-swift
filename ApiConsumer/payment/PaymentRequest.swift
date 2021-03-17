//
//  PaymentRequest.swift
//  ApiConsumer
//
//  Created by carlos alberto apablaza zamorano on 16-03-21.
//

import Foundation

class PaymentRequest : Equatable {
    
    var sale: Sale
    var card: CreditCard
    
    init(sale: Sale, creditCard: CreditCard) {
        self.sale = sale
        self.card = creditCard
    }
    
    func isFill() -> Bool {
        return (self.sale != nil && self.card != nil);
    }
    
    static func == (lhs: PaymentRequest, rhs: PaymentRequest) -> Bool {
        return lhs.card.serialNumber == rhs.card.serialNumber
    }
}
