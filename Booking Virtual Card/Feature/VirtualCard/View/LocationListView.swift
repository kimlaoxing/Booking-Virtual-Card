import Foundation
import Declayout
import Components
import UIKit

final class LocationListView: UIView {
    
    var isFilled: Bool = false
    var returnValue: ((String) -> Void)?
    var valueLabel: String = ""
    
    private lazy var container = UIStackView.make {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .clear
        $0.edges(to: self)
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var hStack = UIStackView.make {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    private lazy var locationPlaceHolder = UILabel.make {
        $0.textColor = .systemGray4
        $0.font = .systemFont(ofSize: 10, weight: .regular)
        $0.textAlignment = .left
        $0.text = "Location"
    }
    
    private lazy var locationValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.text = "No Data"
    }
    
    private lazy var separator = UIView.make {
        $0.height(1)
        $0.backgroundColor = .systemGray4
    }
    
    private lazy var closeButton = UIImageView.make {
        $0.clipsToBounds = true
        $0.image = UIImage(named: "closeButton")
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func subViews() {
        backgroundColor = .white
        addSubviews([
            container.addArrangedSubviews([
                locationPlaceHolder,
                hStack.addArrangedSubviews([
                    locationValue,
                    closeButton
                ]),
                separator
            ])
        ])
    }
    
    private func configureButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(removeContent))
        self.closeButton.addGestureRecognizer(gesture)
    }
    
    @objc private func removeContent() {
        self.locationValue.text = "No Data"
        self.returnValue?(self.valueLabel)
        self.isFilled = false
        self.closeButton.isUserInteractionEnabled = false
    }
    
    func setContent(with location: String) {
        locationValue.text = location
        self.valueLabel = location
        self.isFilled = true
        self.closeButton.isUserInteractionEnabled = true
    }
}
