/// Represents a letter grade that's initializable from a numeric score
public enum LetterGrade: CustomStringConvertible {
    
    case a, aMinus, bPlus, b, bMinus, cPlus, c, cMinus, d, f

    /// All possible letter grades
    public static let all = [LetterGrade.a, .bPlus, .b, .bMinus,
                             .cPlus, .c, .cMinus, .d, .f]

    /// Initializes a letter grade from the provided numerical score
    public init(numerical: Double) {
        switch numerical {
        case (93..<101): self = .a
        case (90..<93): self = .aMinus
        case (87..<90): self = .bPlus
        case (83..<87): self = .b
        case (80..<83): self = .bMinus
        case (77..<80): self = .cPlus
        case (73..<77): self = .c
        case (70..<73): self = .cMinus
        case (60..<70): self = .d
        case (0..<60): self = .f
        default:
            fatalError()
        }
    }

    /// Represents the GPA associated with the provided grade
    public var gradePoints: Double {
        switch self {
        case .a: return 4.0
        case .aMinus: return 3.67
        case .bPlus: return 3.33
        case .b: return 3.0
        case .bMinus: return 2.67
        case .cPlus: return 2.33
        case .c: return 2.0
        case .cMinus: return 1.67
        case .d: return 1.0
        case .f: return 0
        }
    }

    /// A displayable version of the letter grade
    public var description: String {
        switch self {
        case .a: return "A"
        case .aMinus: return "A-"
        case .bPlus: return "B+"
        case .b: return "B"
        case .bMinus: return "B-"
        case .cPlus: return "C+"
        case .c: return "C"
        case .cMinus: return "C-"
        case .d: return "D"
        case .f: return "F"
        }
    }
}
