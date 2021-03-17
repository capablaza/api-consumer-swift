import Foundation
@testable import ApiConsumer

class StorageFake: Storage {
    
    var paymentRequests:[PaymentRequest] = []
    
    func save(request: PaymentRequest) {
        self.paymentRequests.append(request)
    }
    
    func find(sale: Sale) -> PaymentRequest {
        for request in paymentRequests {
            if(request.sale == sale){
                return request
            }
        }
        let card = CreditCard(name: "", serial: 0)
        return PaymentRequest(sale: Sale(), creditCard: card)
    }    
    
}
