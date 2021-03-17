import Foundation
protocol PaymentRestClient {
    func sendPayment(request: PaymentRequest) -> PaymentResponse
}
