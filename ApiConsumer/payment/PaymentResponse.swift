import Foundation

class PaymentResponse {
    public static let OK: Int = 200;
    public static let ERROR: Int = 500;
    
    var code: Int
    
    init(code:Int) {
        self.code = code
    }
    
}
