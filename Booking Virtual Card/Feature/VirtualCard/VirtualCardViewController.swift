import UIKit
import Declayout
import Components

final class VirtualCardViewController: UIViewController {
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
        $0.top(to: view, Padding.NORMAL_CONTENT_INSET)
        $0.bottom(to: view, Padding.double)
        $0.horizontalPadding(to: view)
    }
    
    private lazy var container = ScrollViewContainer.make {

        $0.setSpacingBetweenItems(to: Padding.double * 2)
        $0.isScrollEnabled = false
    }
    
    private lazy var buttonStack = UIStackView.make {
        $0.axis = .horizontal
        $0.spacing = -(Padding.double)
        $0.horizontalPadding(to: container, Padding.double * 2)
        $0.distribution = .fillEqually
    }
    
    private lazy var submitButtonStack = UIStackView.make {
        $0.axis = .horizontal
        $0.horizontalPadding(to: vStack, Padding.double)
        $0.distribution = .fillEqually
    }
    
    private lazy var virtualCardButton = RoundedButton.make {
        $0.setContent(with: "Virtual Card")
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var bookingCardButton = RoundedButton.make {
        $0.setContent(with: "Booking Card")
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var submitButton = RoundedButton.make {
        $0.setContent(with: "Submit")
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var virtualCardView = VirtualCardView()
    private lazy var selectDateView = SelectDateView.make {
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var locationListInputView = LocationListInputView()
    private lazy var locationListView = LocationListView()
    private lazy var submitedView = SubmitedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        defaultButton()
        configureButton()
        setContent()
    }
    
    private func subViews() {
        view.backgroundColor = .white
        view.addSubviews([
            vStack.addArrangedSubviews([
                container.addArrangedSubViews([
                    buttonStack.addArrangedSubviews([
                        virtualCardButton,
                        bookingCardButton
                    ]),
                    virtualCardView,
                    selectDateView,
                    locationListInputView,
                    submitedView
                ]),
                submitButtonStack.addArrangedSubviews([
                submitButton
                ])
            ])
        ])
    }
    
    private func defaultButton() {
        virtualCardButton.setContentWhenTapped()
        bookingCardButton.setContentWhenDidntTapped()
        selectDateView.isHidden = true
        locationListInputView.isHidden = true
        submitButtonStack.isHidden = true
        submitedView.isHidden = true
    }
    
    private func configureButton() {
        let gestureBooking = UITapGestureRecognizer(target: self, action: #selector(didSelectBooking))
        let gestureVirtual = UITapGestureRecognizer(target: self, action: #selector(didSelectVirtual))
        let gestureSubmit = UITapGestureRecognizer(target: self, action: #selector(didSelectSubmit))
        bookingCardButton.addGestureRecognizer(gestureBooking)
        virtualCardButton.addGestureRecognizer(gestureVirtual)
        submitButton.addGestureRecognizer(gestureSubmit)
    }
    
    @objc private func didSelectBooking() {
        bookingCardButton.setContentWhenTapped()
        virtualCardButton.setContentWhenDidntTapped()
        virtualCardView.isHidden = true
        selectDateView.isHidden = false
        locationListInputView.isHidden = false
        submitButtonStack.isHidden = false
        submitedView.isHidden = true
    }
    
    @objc private func didSelectVirtual() {
        virtualCardButton.setContentWhenTapped()
        bookingCardButton.setContentWhenDidntTapped()
        virtualCardView.isHidden = false
        selectDateView.isHidden = true
        locationListInputView.isHidden = true
        submitButtonStack.isHidden = true
        submitedView.isHidden = true
    }
    
    @objc private func didSelectSubmit() {
        submitButtonStack.isHidden = true
        virtualCardView.isHidden = true
        selectDateView.isHidden = true
        locationListInputView.isHidden = true
        submitedView.isHidden = false
    }
    
    private func setContent() {
        virtualCardView.setContent()
    }
    
}

