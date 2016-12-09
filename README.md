# Grades

Grades is a framework for figuring out your standing in your classes, and
finding out the minimum scores on your final exam needed to achieve all
possible letter grades in the class.

# Usage

To calculate grades for a class, make a struct that conforms to the
`ClassGrade` protocol, like so:

```swift
struct CSGrade: ClassGrade {
  let className = "Computer Science"
  let finalWeight = 0.25
  let tests: [Assignment]
  let homework: [Assignment]
  let final: Assignment?

  var assignments: [Assignment {
    var all = tests.map { $0.weighted(by: 0.2) } +
              homework.map { $0.weighted(by: 0.1 }
    if let final = final {
      all.append(final)
    }
    return all
  }

  func withFinal(_ final: Assignment) -> CSGrade {
    return CSGrade(tests: tests,
                   homework: homework,
                   final: final)
  }
}
```

If your class has any more specific logic, such as the final replacing
a test score or anything, just perform those changes inside `withFinal(_:)`.

# Example

There's an example Economics class grade in the tests folder.

# Author

Harlan Haskins ([@harlanhaskins](https://github.com/harlanhaskins))
