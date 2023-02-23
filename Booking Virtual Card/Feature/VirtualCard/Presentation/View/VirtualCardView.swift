import Declayout
import Components

final class VirtualCardView: UIView {
    
    private lazy var container = UIView.make {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .systemRed
        $0.edges(to: self)
    }
    
    private lazy var containerVstack = UIView.make {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .lightGray
        $0.edges(to: container, Padding.half / 2)
    }
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .lightGray
        $0.edges(to: containerVstack, Padding.double)
    }
    
    private lazy var logoImage = UIImageView.make {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var labelStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var titleLabel = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private lazy var idLabel = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .center
    }
    
    private lazy var secondIdLabel = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .center
    }
    
    private lazy var cardTypeLabel = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .center
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
            container.addSubviews([
                containerVstack.addSubviews([
                    vStack.addArrangedSubviews([
                        logoImage,
                        labelStack.addArrangedSubviews([
                            titleLabel,
                            idLabel,
                            secondIdLabel,
                            cardTypeLabel
                        ])
                    ])
                ])
            ])
        ])
    }
    
    func setContent() {
        logoImage.image = UIImage(named: "logo")
        titleLabel.text = "STid Mobile ID"
        idLabel.text = "ID: 3F47EA91"
        secondIdLabel.text = ": 1061677713"
        cardTypeLabel.text = "Card Type: CSN"
    }
}
