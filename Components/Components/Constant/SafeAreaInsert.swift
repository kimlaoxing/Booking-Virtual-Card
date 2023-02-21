import Foundation
import UIKit

public var safeAreaInset: UIEdgeInsets {
    var top: CGFloat = 20, bottom: CGFloat = 0, right: CGFloat = 0, left: CGFloat = 0
    
    let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    if #available(iOS 11.0, *) {
        top = keyWindow?.safeAreaInsets.top ?? 20
        bottom = keyWindow?.safeAreaInsets.bottom ?? 0
        right = keyWindow?.safeAreaInsets.right ?? 0
        left = keyWindow?.safeAreaInsets.left ?? 0
    }
    
    return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}
