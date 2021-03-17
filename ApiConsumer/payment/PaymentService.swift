import Foundation


class PaymentService {
    var logger: Logger
    var emailSender: EmailSender
    var storage: Storage
    
    init(log: Logger, email: EmailSender, storage: Storage) {
        self.logger = log
        self.emailSender = email
        self.storage = storage
    }
    
    func createPaymentRequest(sale: Sale, creditCard: CreditCard) -> PaymentRequest {
        logger.append(msg: "Creating payment for \(sale)")
        return PaymentRequest(sale: sale, creditCard: creditCard)
    }
    
    func sendPayment(request: PaymentRequest, restClient: PaymentRestClient) -> PaymentResponse {
        self.logger.append(msg: "Sending payment .... ");
        let paymentResponse = restClient.sendPayment(request: request)
        self.logger.append(msg: "Payment response : \(paymentResponse)");

        if(paymentResponse.code == PaymentResponse.ERROR ) {
            self.emailSender.sendEmail(request: request)
            self.storage.save(request: request)
        }

        return paymentResponse;
    }
    
}
