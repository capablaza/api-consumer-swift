import Foundation
@testable import ApiConsumer

class EmailSenderMock: EmailSender {
    
    var paymentRequests:[PaymentRequest] = []
    var expectedPaymentRequests:[PaymentRequest] = []
        
    func sendEmail(request: PaymentRequest) {
        self.paymentRequests.append(request)
    }
    
    func expected(request: PaymentRequest){
        self.expectedPaymentRequests.append(request)
    }
    
    func verify() -> Bool {
        let result = self.paymentRequests.difference(from: self.expectedPaymentRequests)
        return (result.count == 0)
    }
    
}
