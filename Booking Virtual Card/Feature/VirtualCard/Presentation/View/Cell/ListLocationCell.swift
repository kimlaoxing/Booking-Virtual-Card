import Declayout
import Components
import UIKit

final class ListLocationCell: UITableViewCell {
    
    var closeButtonCallBack: (() -> Void)?
    
    private lazy var container = UIStackView.make {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .clear
        $0.edges(to: contentView)
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
    
    lazy var closeButton = UIButton.make {
        $0.clipsToBounds = true
        $0.setImage(UIImage(named: "closeButton"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        subViews()
    }
    
    required init?(coder Decoder: NSCoder) {
        super.init(coder: Decoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        backgroundColor = .white
        contentView.addSubviews([
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
    
    func setContent(with location: String) {
        locationValue.text = location
    }
}
