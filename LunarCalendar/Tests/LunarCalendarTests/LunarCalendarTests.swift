import XCTest
@testable import LunarCalendar

final class LunarCalendarTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LunarCalendar().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
