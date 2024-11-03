
import Foundation

struct CellModel {
    let copyright: String
    let date: String
    let explanation: String
    let title: String
    let imageUrl: URL
    
    init(copyright: String,
         date: String,
         explanation: String,
         title: String,
         imageUrl: URL) {
        self.copyright = copyright
        self.date = date
        self.explanation = explanation
        self.title = title
        self.imageUrl = imageUrl
    }
    
    init(from responseModel: ResponseModel) {
        let copyright = responseModel.copyright?.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "n/", with: "")
        self.copyright = copyright ?? "Unknown"
        self.date = responseModel.date
        self.explanation = responseModel.explanation
        self.title = responseModel.title
        self.imageUrl = URL(string: responseModel.url)!
    }
}
