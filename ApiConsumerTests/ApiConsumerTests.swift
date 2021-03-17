//
//  ApiConsumerTests.swift
//  ApiConsumerTests
//
//  Created by carlos alberto apablaza zamorano on 15-03-21.
//

import XCTest
@testable import ApiConsumer

class ApiConsumerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        var paymentRequests:[PaymentRequest] = []
        var expectedPaymentRequests:[PaymentRequest] = []
        
        let request = PaymentRequest(sale: Sale(), creditCard: CreditCard(name: "", serial: 823783))
        
        paymentRequests.append(request)
        expectedPaymentRequests.append(request)
        
        let result = paymentRequests.difference(from: expectedPaymentRequests)
        print(result.count == 0)
        
        XCTAssertEqual(0, result.count)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
