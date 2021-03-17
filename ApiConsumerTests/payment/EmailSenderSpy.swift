import Foundation
@testable import ApiConsumer

class EmailSenderSpy: EmailSender {
    var paymentRequests:[PaymentRequest] = []
            
    func sendEmail(request: PaymentRequest) {
        self.paymentRequests.append(request)
    }
    
    func timesCalled() -> Int {
        return self.paymentRequests.count
    }
        
}
