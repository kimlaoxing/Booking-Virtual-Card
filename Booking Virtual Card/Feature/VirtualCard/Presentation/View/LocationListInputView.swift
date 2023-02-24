import Declayout
import Components

final class LocationListInputView: UIView {
    
    private var pickerView = UIPickerView()
//    var listLocation: [ListAreaResult] = []
    var listLocation: [String] = ["ON Space, GF, ME COMM", "ON Space, L5, ME COMM"]
    var selectCallBackToast: (() -> Void)?
    var callBackSeletedLocation: ((String) -> Void)?
    
    private lazy var container = UIStackView.make {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .clear
        $0.edges(to: self)
        $0.axis = .vertical
        $0.spacing = Padding.reguler
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
        $0.backgroundColor = .lightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurePickerView()
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
                ])
            ])
        ])
    }
    
    private func configurePickerView() {
        locationTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
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
        self.callBackSeletedLocation?(self.listLocation[row])
//        if firstLocationListView.isFilled {
//            if firstLocationListView.valueLabel == self.listLocation[row].location {
//                self.selectCallBackToast?()
//            } else {
//                self.secondLocationListView.setContent(with: self.listLocation[row].location ?? "")
//                self.secondLocationListView.isHidden = false
//                self.emptyData.isHidden = true
//            }
//        } else {
//            self.firstLocationListView.setContent(with: self.listLocation[row].location ?? "")
//            self.firstLocationListView.isHidden = false
//            self.emptyData.isHidden = true
//        }
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
