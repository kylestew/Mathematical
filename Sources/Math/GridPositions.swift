import Foundation

public typealias Position = (x: Double, y: Double)

public struct GridPositions: Sequence, IteratorProtocol {
    let width: Double
    let height: Double
    let xCount: Int
    let yCount: Int

    private let xStep: Double
    private let yStep: Double
    private var i = 0
    private var j = 0

    public init(width: Double, height: Double, xCount: Int, yCount: Int) {
        self.width = width
        self.height = height
        self.xCount = xCount
        self.yCount = yCount
        self.xStep = width / Double(xCount)
        self.yStep = height / Double(yCount)
    }

    public init(width: Double, height: Double, count: Int) {
        self.init(width: width, height: height, xCount: count, yCount: count)
    }

    mutating public func next() -> Position? {
        if i >= xCount {
            // go to next row
            i = 0
            j += 1
        }
        guard j < yCount else {
            // terminal case - finished last row
            return nil
        }

        defer { i += 1 }
        return (Double(i) * xStep, Double(j) * yStep)
    }
}
