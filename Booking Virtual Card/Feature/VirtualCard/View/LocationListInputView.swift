import Foundation
import Declayout
import Components
import UIKit

final class LocationListInputView: UIView {
    
    private lazy var firstLocationListView = LocationListView()
    private lazy var secondLocationListView = LocationListView()
    private var pickerView = UIPickerView()
    private var listLocation: [String] = ["Jakarta", "Bandung"]
    
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
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurePickerView()
        subViews()
        returnData()
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
                    secondLocationListView
                ])
            ])
        ])
    }
    
    private func configurePickerView() {
        locationTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func returnData() {
        self.firstLocationListView.returnValue = { data in
            self.listLocation.append(data)
        }
        
        self.secondLocationListView.returnValue = { data in
            self.listLocation.append(data)
        }
    }
}

extension LocationListInputView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listLocation.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listLocation[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if firstLocationListView.isFilled {
            self.secondLocationListView.setContent(with: self.listLocation[row])
            self.listLocation.remove(at: row)
        } else {
            self.firstLocationListView.setContent(with: self.listLocation[row])
            self.listLocation.remove(at: row)
        }
        self.endEditing(true)
    }
}


extension LocationListInputView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case locationTextField:
            self.pickerView.reloadAllComponents()
        default:
            return true
        }
        pickerView.isUserInteractionEnabled = true
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.reloadAllComponents()
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
