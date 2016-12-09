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
    return EconomicsGrade(quizzes: quizzes, tests: tests, final: final)
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
    func testExample() {
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
        XCTAssertEqualWithAccuracy(dist[.c]!, 80.0, accuracy: 0.1)
        print(dist)
    }

    static var allTests : [(String, (GradesTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
