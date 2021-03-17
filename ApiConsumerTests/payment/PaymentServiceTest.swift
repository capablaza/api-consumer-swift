import XCTest
@testable import ApiConsumer

class PaymentServiceTest: XCTestCase {
    
    var card:CreditCard!
    var logger:Logger!
    var storage:Storage!
    var emailSender: EmailSender!
    var sale: Sale!
    
    override func setUpWithError() throws {
        self.card = CreditCard(name: "money_card", serial: 8926523)
        self.logger = LoggerDummy()
        self.storage = StorageDummy()
        self.emailSender = EmailSenderDummy()
        self.sale = Sale()
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testGivenSaleAndCreditCardWhenBothAreCorrectThenPaymentRequestIsFill() throws {
        let paymentService = PaymentService(log: self.logger, email: self.emailSender, storage: self.storage)
        let paymentRequest = paymentService.createPaymentRequest(sale: self.sale, creditCard: self.card)
        XCTAssertTrue(paymentRequest.isFill())
    }
    
    func testGivenPaymentRequestWhenIsValidThenResponseCodeIs200() throws {
        let paymentService = PaymentService(log: self.logger, email: self.emailSender, storage: self.storage)
        let paymentRequest = paymentService.createPaymentRequest(sale: self.sale, creditCard: self.card)
        
        let restClient = PaymentRestClientStub(code: PaymentResponse.OK)
        
        let paymentResponse = paymentService.sendPayment(request: paymentRequest, restClient: restClient)
        XCTAssertEqual(PaymentResponse.OK, paymentResponse.code)
        
    }
    
    func testGivenPaymentRequestWhenResponseIsErrorThenSendEmail() throws {
        let emailSender = EmailSenderMock()
        
        let paymentService = PaymentService(log: self.logger, email: emailSender, storage: self.storage)
        let paymentRequest = paymentService.createPaymentRequest(sale: self.sale, creditCard: self.card)
        
        let restClient = PaymentRestClientStub(code: PaymentResponse.ERROR)
        
        let paymentResponse = paymentService.sendPayment(request: paymentRequest, restClient: restClient)
        
        XCTAssertEqual(PaymentResponse.ERROR, paymentResponse.code)
        
        emailSender.expected(request: paymentRequest)
        
        XCTAssertTrue(emailSender.verify())
        
    }
    
    func testGivenPaymentRequestWhenResponseIsErrorThenSendEmailOnce() throws {
        let emailSender = EmailSenderSpy()
        
        let paymentService = PaymentService(log: self.logger, email: emailSender, storage: self.storage)
        let paymentRequest = paymentService.createPaymentRequest(sale: self.sale, creditCard: self.card)
        
        let restClient = PaymentRestClientStub(code: PaymentResponse.ERROR)
        
        let paymentResponse = paymentService.sendPayment(request: paymentRequest, restClient: restClient)
        
        
        XCTAssertEqual(PaymentResponse.ERROR, paymentResponse.code)
        XCTAssertEqual(1, emailSender.timesCalled())
        
    }
    
    func testGivenPaymentRequestWhenIsWrongThenStorageHaveRequestSaved() throws {
        let emailSender = EmailSenderDummy()
        let storage = StorageFake()
        let sale = Sale()
        
        let paymentService = PaymentService(log: self.logger, email: emailSender, storage: storage)
        let paymentRequest = paymentService.createPaymentRequest(sale: self.sale, creditCard: self.card)
        
        let restClient = PaymentRestClientStub(code: PaymentResponse.ERROR)
        
        let paymentResponse = paymentService.sendPayment(request: paymentRequest, restClient: restClient)
        XCTAssertEqual(PaymentResponse.ERROR, paymentResponse.code)
        
        let requestFromStorage = storage.find(sale: sale)
        XCTAssertEqual(requestFromStorage, paymentRequest)
        
    }
}
