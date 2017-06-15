public struct SafariPasswordGenerator: RandomStringGenerator {
  public let usableCharacters: UsableCharacters = .alphanumeric
  public let length: Int = 12
  public var count: Int
  
  public init(count: Int = 1) {
    self.count = count
  }
  
  public func generate() -> [String] {
    let generator = PseudoRandomPasswordGenerator(length: 3, usableCharacters: usableCharacters, count: length / 3)
    return (0 ..< count).map { _ in
      generator.generate().joined(separator: "-")
    }
  }
}
