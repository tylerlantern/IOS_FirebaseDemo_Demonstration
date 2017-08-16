

import XCTest
@testable import FirebaseIntroduction
import FirebaseDatabase
import Firebase
class FirebaseIntroductionTests: XCTestCase {
    var storageRef: DatabaseReference!
    override func setUp() {
        super.setUp()
        storageRef = Database.database().reference().child("Storage")
    }
    override func tearDown() {
        super.tearDown()
        storageRef = nil
    }
    func testCreateNode() {
        let expectation = self.expectation(description: "timeout on loading data")
        storageRef.childByAutoId()
        let productRef = storageRef.childByAutoId()
        let product = ["name" : "Icecream"]
        productRef.setValue(product) { (error, ref) in
            expectation.fulfill()
            print(error)
            if error == nil {
                XCTAssertTrue(true)
            }else {
                XCTAssertTrue(false)
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
