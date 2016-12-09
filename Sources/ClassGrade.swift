/// A ClassGrade is a struct that performs its own logic for laying out
/// and weighting assignments. It must provide an array of weighted
/// assignments to be used to calculate the final grade
public protocol ClassGrade {
    /// The name of the class, for display
    var className: String { get }
    
    /// The full array of all weighted assignments
    var assignments: [Assignment] { get }
    
    /// Creates a new assignment with the provided Final Exam score
    func withFinal(_ final: Assignment) -> Self
    
    /// The weight of the final exam (used for final score estimation)
    var finalWeight: Double { get }
}

public extension ClassGrade {
    /// An assignment that represents the total points earned over the course
    public var full: Assignment {
        let (points, total) = assignments.reduce((0, 0)) { accum, assignment in
            return (accum.0 + assignment.points, accum.1 + assignment.total)
        }
        return Assignment(points: points, total: total)
    }

    
    /// Creates a distribution of necessary minimum final exam scores
    /// needed to get each letter grade possible. Impossible grades do not show
    /// up in the distribution
    ///
    /// - Returns: A dictionary from LetterGrade to Double, that represents
    ///            the minimum necessary final exam score to get the letter grade
    ///            in the class
    public func finalDistribution() -> [LetterGrade: Double] {
        var finalGradesMap = [LetterGrade: Double]()
        for i in 0...100 {
            let final = Assignment(points: Double(i), total: 100).weighted(by: finalWeight)
            let grade = withFinal(final).percentage
            let letter = LetterGrade(numerical: grade)
            finalGradesMap[letter] =
                min(finalGradesMap[letter] ?? 999, final.percentage)
        }
        return finalGradesMap
    }

    /// The current grade given the weight of all assignments
    public var percentage: Double {
        return full.percentage
    }
}
