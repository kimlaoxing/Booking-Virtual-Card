import Declayout
import Components

final class EmptyDataView: UIView {
    
    private lazy var emptyData = UILabel.make {
        $0.text = "No Data"
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .lightGray
    }
    
    private lazy var container = UIStackView.make {
        $0.backgroundColor = .white
        $0.edges(to: self)
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
               emptyData
            ])
        ])
    }
}
