import XCTest
import Foundation
@testable import Grades

struct EconomicsGrade: ClassGrade {
  let className = "Introduction to Economics"
  let finalWeight = 0.2
  let quizzes: [Assignment]
  let tests: [Assignment]
  let final: Assignment?

  var assignments: [Assignment] {
    var all = quizzes.map { $0.weighted(by: 0.2) } + tests.map { $0.weighted(by: 0.3) }
    if let final = final {
      all.append(final)
    }
    return all
  }

  func withFinal(_ final: Assignment) -> EconomicsGrade {
    // The professor drops the lowest quiz score and replaces the lowest test
    // with the final if the final is higher
    
    let minQuizIndex = quizzes.enumerated().min {
        $0.element.percentage < $1.element.percentage
    }!.offset
    
    let minTestIndex = tests.enumerated().min {
        $0.element.percentage < $1.element.percentage
    }!.offset
    
    var newQuizzes = quizzes
    newQuizzes.remove(at: minQuizIndex)
    
    var newTests = tests
    if newTests[minTestIndex].percentage < final.percentage {
        newTests[minTestIndex] = final
    }
    
    return EconomicsGrade(quizzes: newQuizzes, tests: newTests, final: final)
  }
}

private struct Constants {
    static let percentageFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.minimumFractionDigits = 2
        return f
    }()
}

extension ClassGrade {
    func printStanding() {
        print("\(className):")
        print("  Current grade: \(LetterGrade(numerical: percentage)) ",
            terminator: "")
        print("(\(Constants.percentageFormatter.string(from: NSNumber(value: percentage / 100))!))")
        let dist = finalDistribution()
        for grade in LetterGrade.all {
            print("  \(grade): ", terminator: "")
            if let score = dist[grade] {
                print("\(score)")
            } else {
                print("impossible")
            }
        }
        print()
    }
}

class GradesTests: XCTestCase {
    func testSpecialClass() {
        let econ = EconomicsGrade(quizzes: [
            Assignment(points: 50, total: 50),
            Assignment(points: 44, total: 50),
            Assignment(points: 20, total: 50)
        ], tests: [
            Assignment(points: 80, total: 90),
            Assignment(points: 40, total: 90),
            Assignment(points: 70, total: 90)
        ], final: nil)
        let dist = econ.finalDistribution()
        econ.printStanding()
        XCTAssertEqual(dist[.a], nil)
        XCTAssertEqualWithAccuracy(dist[.c]!, 45, accuracy: 0.1)
        print(dist)
    }
    
    func testNormalClass() {
        let spanish = AnyClassGrade(className: "Spanish 204",
                                    finalWeight: 0.35,
                                    weightedAssignments: [
                                        Assignment(points: 10, total: 10).weighted(by: 0.2),
                                        Assignment(points: 6, total: 10).weighted(by: 0.2),
                                        Assignment(points: 8, total: 10).weighted(by: 0.2),
                                        Assignment(points: 10, total: 10).weighted(by: 0.05),
                                    ], final: nil)
        let dist = spanish.finalDistribution()
        spanish.printStanding()
        XCTAssertNotNil(dist[.a])
        XCTAssertNotNil(dist[.b])
        XCTAssertEqualWithAccuracy(dist[.a]!, 96.0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(dist[.b]!, 84.0, accuracy: 0.01)
    }
    

    static var allTests : [(String, (GradesTests) -> () throws -> Void)] {
        return [
            ("testSpecialClass", testSpecialClass),
        ]
    }
}
