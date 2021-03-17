import Foundation

class CreditCard {
    
    var name: String
    var serialNumber: Int
    
    public init (name: String, serial:Int){
        self.name = name
        self.serialNumber = serial
    }
}
