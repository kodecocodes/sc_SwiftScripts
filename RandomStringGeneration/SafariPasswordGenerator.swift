struct SafariPasswordGenerator: RandomStringGenerator {
  let usableCharacters: UsableCharacters = .alphanumeric
  let length: Int = 12
  var count: Int
  
  init(count: Int = 1) {
    self.count = count
  }
  
  func generate() -> [String] {
    let generator = PseudoRandomPasswordGenerator(length: 3, usableCharacters: usableCharacters, count: length / 3)
    return (0 ..< count).map { _ in
      generator.generate().joined(separator: "-")
    }
  }
}
