
public struct NormRange: Sequence, IteratorProtocol {
    var n: Int
    private var i: Int
    public init(n: Int) {
        self.n = n
        self.i = 0
    }
    mutating public func next() -> Double? {
        if i < n {
            defer { i += 1 }
            return Double(i) / Double(n - 1)
        }
        return nil
    }
}

