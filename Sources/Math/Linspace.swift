import Foundation

struct Math {}

extension Math {
    /**
     Returns num evenly spaced samples, calculated over the interval [start, stop].

     The endpoint of the interval can optionally be excluded.

     - Parameters:
     - start: The starting value of the sequence.
     - end: The end value of the sequence, unless endpoint is set to False. In that case, the sequence consists of all but the last of num + 1 evenly spaced samples, so that stop is excluded. Note that the step size changes when endpoint is False.
     - num: Number of samples to generate. Default is 50. Must be non-negative.
     - endpoint: If True, stop is the last sample. Otherwise, it is not included. Default is True.

     - Returns: There are num equally spaced samples in the closed interval [start, stop] or the half-open interval [start, stop) (depending on whether endpoint is True or False).
     */
    static func linspace(start: Double, end: Double, num: Int = 50, endpoint: Bool = true) -> [Double] {
        let stride = (end - start) / Double(endpoint ? num - 1 : num)
        var pos = start
        var arr: [Double] = []
        for _ in 0..<num {
            arr.append(pos)
            pos += stride
        }
        return arr
    }
}
