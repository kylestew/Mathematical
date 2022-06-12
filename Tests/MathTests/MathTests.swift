import XCTest
@testable import Math

final class MathTests: XCTestCase {
    private func testArrayEquality(_ results: [Double], _ expected: [Double]) {
        XCTAssertEqual(results[1], expected[1], accuracy: 0.001)
    }

    func testLinspace() {
        let results = Math.linspace(start: 0, end: 1, num: 6)
        let expected = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        testArrayEquality(results, expected)
    }

    func testLinspaceNoEnd() {
        let results = Math.linspace(start: 0, end: 1, num: 6, endpoint: false)
        let expected = [0, 0.166, 0.333, 0.5, 0.666, 0.833 ]
        testArrayEquality(results, expected)
    }
}
