import XCTest
@testable import GOL

final class GOLTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GOL().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
