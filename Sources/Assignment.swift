
/// A specific assignment given during the course.
public struct Assignment {
    /// The number of points earned
    public let points: Double
    
    /// The total number of available points
    public let total: Double
    
    /// The percentage earned by the student on this assignment
    public var percentage: Double {
        return (points / total) * 100
    }
    
    
    /// Returns an assignment that represents the same percentage as this
    /// assignment, but weighted by how much it affects your final grade.
    ///
    /// - Parameter percent: The percentage to weight by, between 0.0 and 1.0
    /// - Returns: A new assignment with the appropriate weight
    public func weighted(by percent: Double) -> Assignment {
        return Assignment(points: points * percent, total: total * percent)
    }
}
