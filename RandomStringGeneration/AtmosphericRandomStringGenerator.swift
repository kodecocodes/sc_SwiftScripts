import Foundation

struct AtmosphericNoisePasswordGenerator: RandomStringGenerator {
  var usableCharacters: UsableCharacters
  var length: Int
  var count: Int
  
  init(length: Int, usableCharacters: UsableCharacters = .alphanumeric, count: Int = 1) {
    self.length = length
    self.usableCharacters = usableCharacters
    self.count = count
  }
  
  func generate() -> [String] {
    guard let url = url() else { return [] }
    var data: Data? = nil
    
    let semaphore = DispatchSemaphore(value: 0)
    let task = URLSession.shared.dataTask(with: url) { (taskData, _, error) in
      data = taskData
      if data == nil, let error = error {
        print(error.localizedDescription)
      }
      semaphore.signal()
    }
    
    task.resume()
    semaphore.wait()
    
    if let data = data, let response = String(data: data, encoding: .utf8) {
      return response.components(separatedBy: "\n")
    }
    return []
  }
  
  private func url() -> URL? {
    var cmpts = URLComponents(string: "https://www.random.org/strings")
    cmpts?.queryItems = [
      URLQueryItem(name: "num", value: "\(count)"),
      URLQueryItem(name: "len", value: "\(length)"),
      URLQueryItem(name: "digits", value: usableCharacters.contains(.numbers) ? "on" : "off"),
      URLQueryItem(name: "upperalpha", value: usableCharacters.contains(.uppercase) ? "on" : "off"),
      URLQueryItem(name: "loweralpha", value: usableCharacters.contains(.lowercase) ? "on" : "off"),
      URLQueryItem(name: "unique", value: "on"),
      URLQueryItem(name: "format", value: "plain"),
      URLQueryItem(name: "rnd", value: "new")
    ]
    return cmpts?.url
  }
}
