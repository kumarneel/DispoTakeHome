import UIKit

struct GifInfo: Codable {
    var id: String
    var gifUrl: URL
    var text: String
    var shares: Int
    var title: String
    var backgroundColor: Color
    var tenorUrl: URL
    var tags: [String]
    
    struct Color : Codable {
        var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        
        var uiColor : UIColor {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        
        init(uiColor : UIColor) {
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
    }
    init(id: String, title: String, gifUrl: URL, text: String, shares: Int, backgroundColor: UIColor, tenorUrl: URL, tags: [String]) {
        // This initializer is not called if Decoded from JSON!
        self.title = title
        self.id = id
        self.gifUrl = gifUrl
        self.text = text
        self.shares = shares
        self.backgroundColor = Color(uiColor: backgroundColor)
        self.tenorUrl = tenorUrl
        self.tags = tags
    }
}

