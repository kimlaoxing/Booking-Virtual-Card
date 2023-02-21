import Foundation
import Declayout
import Components

final class SubmitedView: UIView {
    
    private lazy var container = UIStackView.make {
        $0.backgroundColor = .clear
        $0.edges(to: self)
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var descriptionLabel = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.text = "Card request submitted! You will be notified by email"
    }
    
    private lazy var submitIcon = UIImageView.make {
        $0.clipsToBounds = true
        $0.image = UIImage(named: "submitIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func subViews() {
        backgroundColor = .white
        addSubviews([
            container.addArrangedSubviews([
                submitIcon,
                descriptionLabel
            ])
        ])
    }
}
