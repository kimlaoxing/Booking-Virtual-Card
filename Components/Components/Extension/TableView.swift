import UIKit

typealias UITableViewDataSourceDelegate = UITableViewDataSource & UITableViewDelegate
typealias UICollectionViewDataSourceDelegate = UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension UITableView {
    public static let contentSizeKeyPath = "contentSize"
    
    public func reloads() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    public func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 1
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 12, weight: .regular)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    public func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
