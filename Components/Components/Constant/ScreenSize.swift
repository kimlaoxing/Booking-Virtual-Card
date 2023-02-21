import Foundation
import UIKit

public struct ScreenSize {
    public static let width = UIScreen.main.bounds.width
    public static let height = UIScreen.main.bounds.height
    
    public static let availableWidth = width - CGFloat(18 * (2 + 1))
    public static let widthPerItem = (availableWidth / 2) + 4
    public static let heightPerItem = widthPerItem
}

public struct Constants {
    static let DefaultLocale = Locale(identifier: "id_ID")
}
