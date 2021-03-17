import Foundation
@testable import ApiConsumer

class PaymentRestClientStub: PaymentRestClient {
    
    var code:Int
    
    init(code:Int) {
        self.code = code
    }
    
    func sendPayment(request: PaymentRequest) -> PaymentResponse {
        return PaymentResponse(code: self.code)
    }
    
}
