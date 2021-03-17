import Foundation
@testable import ApiConsumer

class StorageDummy: Storage {
    
    func save(request: PaymentRequest){
        //TODO
    }
    
    func find(sale: Sale) -> PaymentRequest{
        //TODO
        let sale = Sale()
        let card = CreditCard(name: "", serial: 0)
        return PaymentRequest(sale: sale, creditCard: card)
    }
}
