import Declayout
import Components

final class SelectDateView: UIView {
    
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    private let formPickerView = UIPickerView()
    var callBackToast: ((String) -> Void)?
    var callBackStartDate: ((String) -> Void)?
    var callBackEndDate: ((String) -> Void)?
    
    private lazy var container = UIStackView.make {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .clear
        $0.edges(to: self)
    }
    
    private lazy var datePickerStack = UIStackView.make {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = Padding.double
    }
    
    private lazy var startDateStack = UIStackView.make {
        $0.axis = .horizontal
        $0.spacing = Padding.half
    }
    
    private lazy var endDateStack = UIStackView.make {
        $0.axis = .horizontal
        $0.spacing = Padding.half
    }
    
    private lazy var calendarIcon = UIImageView.make {
        $0.image = UIImage(named: "calendarIcon")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.dimension(25)
    }
    
    private lazy var calendarIcon2 = UIImageView.make {
        $0.image = UIImage(named: "calendarIcon")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.dimension(25)
    }
    
    private lazy var startDate = UITextField.make {
        $0.placeholder = "Start Date"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.borderStyle = UITextField.BorderStyle.roundedRect
        $0.autocorrectionType = UITextAutocorrectionType.no
        $0.keyboardType = UIKeyboardType.default
        $0.returnKeyType = UIReturnKeyType.done
        $0.clearButtonMode = UITextField.ViewMode.whileEditing
        $0.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        $0.delegate = self
        $0.backgroundColor = .lightGray
        $0.text = ""
    }
    
    private lazy var endDate = UITextField.make {
        $0.placeholder = "End Date"
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
        subViews()
        creatDoneButtonForStartDate()
        configureEndDateDatePicker()
        configureStartDateDatePicker()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func subViews() {
        backgroundColor = .white
        addSubviews([
            container.addArrangedSubviews([
                datePickerStack.addArrangedSubviews([
                    startDateStack.addArrangedSubviews([
                        startDate,
                        calendarIcon
                    ]),
                    endDateStack.addArrangedSubviews([
                        endDate,
                        calendarIcon2
                    ])
                ])
            ])
        ])
    }
    
    private func configureStartDateDatePicker() {
        startDatePicker.datePickerMode = .date
        startDatePicker.addTarget(self, action: #selector(startDatePickerChanged(picker:)), for: .valueChanged)
        
        if #available(iOS 14.0, *) {
            startDatePicker.preferredDatePickerStyle = .inline
        }
        startDate.inputView = startDatePicker
        startDate.addTarget(self, action: #selector(onStartDateDidBegin(_:)), for: .editingDidBegin)
    }
    
    private func configureEndDateDatePicker() {
        if let text = startDate.text {
            if text.isEmpty {
                self.callBackToast?("Please Select Start Date First")
            } else {
                endDate.inputView = endDatePicker
                endDate.addTarget(self, action: #selector(onEndDateDidBegin(_:)), for: .editingDidBegin)
                endDatePicker.datePickerMode = .date
                endDatePicker.addTarget(self, action: #selector(endDatePickerChanged(picker:)), for: .valueChanged)
                endDatePicker.minimumDate = self.startDatePicker.date
                
                if #available(iOS 14.0, *) {
                    endDatePicker.preferredDatePickerStyle = .inline
                }
                creatDoneButtonForEndDate()
            }
        }
    }
    
    private func creatDoneButtonForStartDate() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneStartDate))
        toolBar.setItems([doneBtn], animated: true)
        startDate.inputAccessoryView = toolBar
    }
    
    private func creatDoneButtonForEndDate() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneEndDate))
        toolBar.setItems([doneBtn], animated: true)
        endDate.inputAccessoryView = toolBar
    }
    
    @objc func doneStartDate() {
        startDate.text = self.startDatePicker.date.toString(with: .reverseServerDate)
        self.callBackStartDate?(self.startDatePicker.date.toString(with: .dayMonthYearWithTime))
        configureEndDateDatePicker()
        self.endEditing(true)
    }
    
    @objc func doneEndDate() {
        endDate.text = self.endDatePicker.date.toString(with: .reverseServerDate)
        self.callBackEndDate?(self.endDatePicker.date.toString(with: .dayMonthYearWithTime))
        self.endEditing(true)
    }
    
    @objc func startDatePickerChanged(picker: UIDatePicker) {
        startDate.text = picker.date.toString(with: .reverseServerDate)
        self.callBackStartDate?(self.startDatePicker.date.toString(with: .dayMonthYearWithTime))
        configureEndDateDatePicker()
    }
    
    @objc func endDatePickerChanged(picker: UIDatePicker) {
        endDate.text = picker.date.toString(with: .reverseServerDate)
        self.callBackEndDate?(self.endDatePicker.date.toString(with: .dayMonthYearWithTime))
    }
    
    @objc private func onStartDateDidBegin(_ textfield: UITextField) {
        if let text = textfield.text {
            if text.isEmpty{
                startDatePicker.setDate(Date(), animated: true)
                startDate.text = Date().toString(with: .reverseServerDate)
            }
            startDatePicker.setDate(Date(), animated: true)
        }
    }
    
    @objc private func onEndDateDidBegin(_ textfield: UITextField) {
        if let text = startDate.text {
            if text.isEmpty {
                self.callBackToast?("Please Select Start Date First")
            } else {
                endDatePicker.setDate(Date(), animated: true)
                endDate.text = Date().toString(with: .reverseServerDate)
            }
        }
    }
}


extension SelectDateView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case endDate:
            if let text = startDate.text {
                if text.isEmpty {
                    self.callBackToast?("Please Select Start Date First")
                }
            }
        case startDate:
            endDate.text = ""
        default:
            break
        }
        
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
