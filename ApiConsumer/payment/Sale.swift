//
//  Sale.swift
//  ApiConsumer
//
//  Created by carlos alberto apablaza zamorano on 16-03-21.
//

import Foundation

class Sale : Equatable {
    var amount:Int = 0
    
    static func == (lhs: Sale, rhs: Sale) -> Bool {
        return lhs.amount == rhs.amount
    }
    
    
}
