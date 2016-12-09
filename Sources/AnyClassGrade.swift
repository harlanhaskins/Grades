/// AnyClassGrade is a simple struct that doesn't declare any fields specially
/// and has no special logic for handling assignments.
/// Use this struct if your class doesn't have any special handling of scores.
public struct AnyClassGrade: ClassGrade {
    /// The name of the class
    public let className: String

    /// The weight of the class's final exam
    public let finalWeight: Double

    /// All weighted assignments in the class
    public let weightedAssignments: [Assignment]

    /// The final exam score
    public let final: Assignment?
    
    /// An array of all assignments, including the final
    public var assignments: [Assignment] {
        var all = weightedAssignments
        if let final = final {
            all.append(final)
        }
        return all
    }
    
    /// Creates a new AnyClassGrade with the provided final exam
    ///
    /// - Parameter final: The final exam's grade
    /// - Returns: A new AnyClassGrade with the final applied
    public func withFinal(_ final: Assignment) -> AnyClassGrade {
        return AnyClassGrade(className: className,
                             finalWeight: finalWeight,
                             weightedAssignments: weightedAssignments,
                             final: final)
    }
}
