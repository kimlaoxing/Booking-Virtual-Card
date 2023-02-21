import Declayout

public final class ScrollViewContainer: UIScrollView, UIScrollViewDelegate {
  
  var touchCallback: (() -> Void)?
  
  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    self.touchCallback?()
  }
  
  private lazy var stackView = UIStackView.make {
    $0.axis = .vertical
    $0.edges(to: self).center(.horizontal, to: self)
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    delegate = self
    addSubviews([stackView])
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  @discardableResult
  public func addArrangedSubViews(_ views: [UIView]) -> Self {
    self.stackView.addArrangedSubviews(views)
    return self
  }
  
  @discardableResult
  public func addArrangedSubViewToFirstIndex(_ view: UIView) -> Self {
    self.stackView.insertSubview(view, at: 0)
    return self
  }
  
  @discardableResult
  public func setSpacingBetweenItems(to value: CGFloat) -> Self {
    self.stackView.spacing = value
    return self
  }
  
  @discardableResult
  public func setBackgroundColor(color: UIColor?) -> Self {
    self.backgroundColor = color
    return self
  }
  
  @discardableResult
  public func showsVerticalScrollIndicator(_ isShow: Bool) -> Self {
    self.showsVerticalScrollIndicator = isShow
    return self
  }
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > 10 {
      self.touchCallback?()
    }
  }
}
