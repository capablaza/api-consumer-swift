import Foundation


protocol Storage {
    func save(request: PaymentRequest)
    func find(sale: Sale) -> PaymentRequest
}
