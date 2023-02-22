import Foundation
import Declayout
import Components
import UIKit

final class SelectDateView: UIView {
    
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    private let formPickerView = UIPickerView()
    
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
        $0.backgroundColor = .white
    }
    
    private lazy var endDate = UITextField.make {
        $0.placeholder = "endDate Date"
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
        subViews()
        creatDoneButtonForStartDate()
        creatDoneButtonForEndDate()
        configureDatePicker()
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
    
    private func configureDatePicker() {
        startDatePicker.datePickerMode = .date
        startDatePicker.maximumDate = Date()
        startDatePicker.addTarget(self, action: #selector(startDatePickerChanged(picker:)), for: .valueChanged)
        
        if #available(iOS 14.0, *) {
            startDatePicker.preferredDatePickerStyle = .inline
        }
        startDate.inputView = startDatePicker
        startDate.addTarget(self, action: #selector(onStartDateDidBegin(_:)), for: .editingDidBegin)
        
        endDatePicker.datePickerMode = .date
        endDatePicker.addTarget(self, action: #selector(endDatePickerChanged(picker:)), for: .valueChanged)
        endDatePicker.setDate(Date(), unit: .day, deltaMinimum: -30, deltaMaximum: 1, animated: true)
        
        if #available(iOS 14.0, *) {
            endDatePicker.preferredDatePickerStyle = .inline
        }
        endDate.inputView = endDatePicker
        endDate.addTarget(self, action: #selector(onEndDateDidBegin(_:)), for: .editingDidBegin)
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
        self.endEditing(true)
    }
    
    @objc func doneEndDate() {
        endDate.text = self.endDatePicker.date.toString(with: .reverseServerDate)
        self.endEditing(true)
    }
    
    @objc func startDatePickerChanged(picker: UIDatePicker) {
        startDate.text = picker.date.toString(with: .reverseServerDate)
    }
    
    @objc func endDatePickerChanged(picker: UIDatePicker) {
        endDate.text = picker.date.toString(with: .reverseServerDate)
    }
    
    @objc private func onStartDateDidBegin(_ textfield: UITextField){
        if let text = textfield.text {
            if text.isEmpty{
                startDatePicker.setDate(Date(), animated: true)
                startDate.text = Date().toString(with: .reverseServerDate)
            }
            startDatePicker.setDate(Date(), animated: true)
        }
    }
    
    @objc private func onEndDateDidBegin(_ textfield: UITextField){
        if let text = textfield.text {
            if text.isEmpty{
                endDatePicker.setDate(Date(), animated: true)
                endDate.text = Date().toString(with: .reverseServerDate)
            }
            endDatePicker.setDate(Date(), animated: true)
        }
    }
}


extension SelectDateView: UITextFieldDelegate {
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




