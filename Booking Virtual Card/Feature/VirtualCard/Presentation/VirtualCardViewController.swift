import Declayout
import Components
import UIKit

final class VirtualCardViewController: UIViewController {
    
    var viewModel: VirtualCardViewModel?
    var selectedLocation: [String] = []
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
        $0.top(to: view, Padding.NORMAL_CONTENT_INSET)
        $0.bottom(to: view, Padding.double)
        $0.horizontalPadding(to: view)
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var emptyDataView = EmptyDataView()
    
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
    
    private lazy var selectDateView = SelectDateView.make {
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var locationListTableView = UITableView.make {
        $0.delegate = self
        $0.dataSource = self
        $0.register(ListLocationCell.self, forCellReuseIdentifier: "ListLocationCell")
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }
    
    private var locationListTableViewHeight: NSLayoutConstraint? {
        didSet { locationListTableViewHeight?.activated() }
    }
    
    private lazy var virtualCardView = VirtualCardView()
    private lazy var locationListInputView = LocationListInputView()
    private lazy var submitedView = SubmitedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        viewModel?.viewDidLoad()
        subViews()
        defaultButton()
        configureButton()
        setContent()
        handleNotification()
        bind()
        configureTableView()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let newvalue = change?[.newKey], keyPath == UITableView.contentSizeKeyPath {
            let newsize  = newvalue as! CGSize
            self.vStack.layoutIfNeeded()
            self.container.layoutIfNeeded()
            self.locationListTableViewHeight?.constant = newsize.height
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationListTableView.addObserver(self, forKeyPath: UITableView.contentSizeKeyPath, options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationListTableView.removeObserver(self, forKeyPath: UITableView.contentSizeKeyPath, context: nil)
    }
    
    private func bind() {
//        self.viewModel?.listArea.observe(on: self) { [weak self] data in
//            guard let self = self else { return }
//            self.locationListInputView.listLocation = data
//        }
        
//        self.viewModel?.baseViewState.observe(on: self) { [weak self] view in
//            guard let self = self, let view = view else { return }
//            self.handleViewState(with: view)
//        }
        
        self.viewModel?.error.observe(on: self) { [weak self] error in
            guard let error = error, let self = self else { return }
            if error != "" {
                self.showError(with: error)
            }
        }
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
                    locationListTableView,
                    emptyDataView,
                    submitedView
                ]),
                submitButtonStack.addArrangedSubviews([
                    submitButton
                ])
            ])
        ])
    }
    
    private func configureTableView() {
        locationListTableViewHeight = locationListTableView.heightAnchor.constraint(equalToConstant: 1)
        locationListTableViewHeight?.priority = UILayoutPriority.init(999)
        locationListTableViewHeight?.isActive = true
    }
    
    private func handleViewState(with state: BaseViewState) {
        switch state {
        case .loading:
            self.vStack.isHidden = true
            self.manageLoadingActivity(isLoading: true)
        case .normal:
            self.vStack.isHidden = false
            self.manageLoadingActivity(isLoading: false)
        case .empty:
            self.vStack.isHidden = false
            self.manageLoadingActivity(isLoading: false)
        }
    }
    
    private func defaultButton() {
        virtualCardButton.setContentWhenTapped()
        bookingCardButton.setContentWhenDidntTapped()
        selectDateView.isHidden = true
        locationListInputView.isHidden = true
        locationListTableView.isHidden = true
        submitButtonStack.isHidden = true
        submitedView.isHidden = true
        emptyDataView.isHidden = true
    }
    
    private func configureButton() {
        let gestureBooking = UITapGestureRecognizer(target: self, action: #selector(didSelectBooking))
        let gestureVirtual = UITapGestureRecognizer(target: self, action: #selector(didSelectVirtual))
        let gestureSubmit = UITapGestureRecognizer(target: self, action: #selector(didSelectSubmit))
        let gestureBackground = UITapGestureRecognizer.init(target: self, action: #selector(backgroundTap))
        vStack.addGestureRecognizer(gestureBackground)
        bookingCardButton.addGestureRecognizer(gestureBooking)
        virtualCardButton.addGestureRecognizer(gestureVirtual)
        submitButton.addGestureRecognizer(gestureSubmit)
    }
    
    private func setContent() {
        virtualCardView.setContent()
    }
    
    private func handleNotification() {
        self.locationListInputView.selectCallBackToast = {
            self.locationIsSelected()
        }
        
        self.selectDateView.callBackToast = { message in
            self.showError(with: message)
        }
        
        self.locationListInputView.callBackSeletedLocation = { data in
            if self.selectedLocation.contains(data) {
                self.showError(with: "location has been selected")
            } else {
                self.selectedLocation.append(data)
            }
            self.emptyViewConfigure()
            self.locationListTableView.reloadData()
        }
    }
    
    @objc private func didSelectBooking() {
        bookingCardButton.setContentWhenTapped()
        virtualCardButton.setContentWhenDidntTapped()
        virtualCardView.isHidden = true
        selectDateView.isHidden = false
        locationListInputView.isHidden = false
        locationListTableView.isHidden = false
        submitButtonStack.isHidden = false
        submitedView.isHidden = true
        emptyViewConfigure()
    }
    
    @objc private func didSelectVirtual() {
        virtualCardButton.setContentWhenTapped()
        bookingCardButton.setContentWhenDidntTapped()
        virtualCardView.isHidden = false
        selectDateView.isHidden = true
        locationListInputView.isHidden = true
        locationListTableView.isHidden = true
        submitButtonStack.isHidden = true
        submitedView.isHidden = true
        emptyDataView.isHidden = true
    }
    
    @objc private func didSelectSubmit() {
        submitButtonStack.isHidden = true
        virtualCardView.isHidden = true
        selectDateView.isHidden = true
        locationListInputView.isHidden = true
        locationListTableView.isHidden = true
        submitedView.isHidden = false
    }
    
    @objc func backgroundTap() {
        self.view.endEditing(true)
    }
    
    @objc func handleRegister(_ sender: UIButton){
        self.selectedLocation.remove(at:sender.tag)
        locationListTableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        locationListTableView.reloadData()
        emptyViewConfigure()
    }
    
    private func emptyViewConfigure() {
        if self.selectedLocation.count > 0 {
            emptyDataView.isHidden = true
        } else {
            emptyDataView.isHidden = false
        }
    }
}

extension VirtualCardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = self.selectedLocation.count
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListLocationCell", for: indexPath) as! ListLocationCell
        cell.setContent(with: self.selectedLocation[indexPath.row])
        cell.closeButton.tag = indexPath.row
        cell.closeButton.addTarget(self, action: #selector(handleRegister(_:)), for: .touchUpInside)
        return cell
    }
}
