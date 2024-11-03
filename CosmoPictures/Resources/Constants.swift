
import UIKit

enum Constants {
    static let host = "https://api.nasa.gov/planetary/apod"
    static let apiKey = "k5fosP5LyRAbh2ZVRz63zFQGGZHbOS0sX4QJMvP8"
    static let count = 10
}

enum MainLayoutConstants {
    static let cellHeight: CGFloat = 100
    static let insets = UIEdgeInsets(top: 25, left: 8, bottom: -10, right: -8)
    static let minimumInteritemSpacing: CGFloat = 0
    static let minimumLineSpacing: CGFloat = 8
}

enum DetailLayoutConstants {
    static let insets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
    static let minimumInteritemSpacing: CGFloat = 0
    static let minimumLineSpacing: CGFloat = 0
}
