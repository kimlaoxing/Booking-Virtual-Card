import UIKit
import Toast_Swift

extension UIViewController {
    public func locationIsSelected() {
        self.view.makeToast("Location is selected")
    }
}
