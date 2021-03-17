import Foundation

protocol EmailSender {
    func sendEmail(request:PaymentRequest)
}
