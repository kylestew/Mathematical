import Swift

public struct CartesianProduct<Base1, Base2> where Base1: Collection, Base2: Collection {
    @usableFromInline internal let base1: Base1
    @usableFromInline internal let base2: Base2

    @inlinable
    internal init(base1: Base1, base2: Base2) {
        self.base1 = base1
        self.base2 = base2
    }
}

extension CartesianProduct {
    public struct Iterator {
        @usableFromInline internal var base1Iterator: Base1.Iterator
        @usableFromInline internal var base1Element: Base1.Element?
        @usableFromInline internal let base2: Base2
        @usableFromInline internal var base2Iterator: Base2.Iterator

        @inlinable
        internal init(base1: Base1, base2: Base2) {
            self.base1Iterator = base1.makeIterator()
            self.base1Element = self.base1Iterator.next()
            self.base2 = base2
            self.base2Iterator = base2.makeIterator()
        }
    }
}

extension CartesianProduct.Iterator: IteratorProtocol {
    public typealias Element = (Base1.Element, Base2.Element)

    @inlinable
    public mutating func next() -> Element? {
        guard let base1Element = self.base1Element else { return nil }

        if let element = self.base2Iterator.next() {
            return (base1Element, element)
        } else {
            self.base1Element = self.base1Iterator.next()
            guard let base1Element = self.base1Element else { return nil }

            self.base2Iterator = self.base2.makeIterator()
            if let element = self.base2Iterator.next() {
                return (base1Element, element)
            } else {
                self.base1Element = nil
                return nil
            }
        }
    }
}

extension CartesianProduct: Sequence {
    public typealias Element = (Base1.Element, Base2.Element)

    @inlinable
    public func makeIterator() -> Iterator {
        return Iterator(base1: self.base1, base2: self.base2)
    }

    @inlinable
    public var underestimatedCount: Int {
        return self.base1.underestimatedCount * self.base2.underestimatedCount
    }
}

// TODOs: Collection, BidirectionalCollection, RandomAccessCollection conformances
//extension CartesianProduct: Collection {}
//extension CartesianProduct: BidirectionalCollection where Base1: BidirectionalCollection, Base2: BidirectionalCollection {}
//extension CartesianProduct: RandomAccessCollection where Base1: RandomAccessCollection, Base2: RandomAccessCollection {}

extension Collection {
    @inlinable
    public func cartesianProduct<C>(with other: C) -> CartesianProduct<Self, C> where C: Collection {
        return CartesianProduct(base1: self, base2: other)
    }
}
