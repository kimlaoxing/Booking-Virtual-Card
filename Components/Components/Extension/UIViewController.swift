import UIKit
import Toast_Swift

extension UIViewController {
    public func showError(with error: String) {
        self.view.makeToast(error)
    }
    
    public func locationIsSelected() {
        self.view.makeToast("Location is selected")
    }
    
    public func manageLoadingActivity(isLoading: Bool) {
        if isLoading {
            showLoadingActivity()
        } else {
            hideLoadingActivity()
        }
    }
    
    public func showLoadingActivity() {
        self.view.makeToastActivity(.center)
    }
    
    public func hideLoadingActivity() {
        self.view.hideToastActivity()
    }
}
