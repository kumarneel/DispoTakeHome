import UIKit

struct GifInfo: Codable {
    var id: Int
    var gifUrl: URL
    var text: String
    var shares: Int
    var title: String
    var tenorUrl: URL
    var tags: [String]
  
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.id = dictionary["id"] as? Int ?? 0
        self.gifUrl = dictionary["gifUrl"] as? URL ?? URL(string: "http://www.google.com")!
        self.text = dictionary["text"] as? String ?? ""
        self.shares = dictionary["shares"] as? Int ?? 0
        self.tenorUrl = dictionary["uid"] as? URL ?? URL(string: "http://www.google.com")!
        self.tags = dictionary["uid"] as? [String] ?? []

    }
}

