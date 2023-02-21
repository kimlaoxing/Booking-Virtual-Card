import Foundation
import Declayout
import Components
import UIKit

final class LocationListInputView: UIView {
    
    private lazy var firstLocationListView = LocationListView()
    private lazy var secondLocationListView = LocationListView()
    private lazy var thirdLocationListView = LocationListView()
    
    private lazy var container = UIStackView.make {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .clear
        $0.edges(to: self)
        $0.axis = .vertical
        $0.spacing = Padding.reguler
    }
    
    private lazy var locationListStack = UIStackView.make {
        $0.axis = .vertical
        $0.horizontalPadding(to: container, Padding.double)
        $0.spacing = Padding.half
    }
    
    private lazy var datePickerStack = UIStackView.make {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = Padding.double
    }
    
    private lazy var locationTextField = UITextField.make {
        $0.placeholder = "Locations"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.borderStyle = UITextField.BorderStyle.roundedRect
        $0.autocorrectionType = UITextAutocorrectionType.no
        $0.keyboardType = UIKeyboardType.default
        $0.returnKeyType = UIReturnKeyType.done
        $0.clearButtonMode = UITextField.ViewMode.whileEditing
        $0.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        $0.delegate = self
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
                datePickerStack.addArrangedSubviews([
                    locationTextField
                ]),
                locationListStack.addArrangedSubviews([
                    firstLocationListView,
                    secondLocationListView,
                    thirdLocationListView
                ])
            ])
        ])
    }
}


extension LocationListInputView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
