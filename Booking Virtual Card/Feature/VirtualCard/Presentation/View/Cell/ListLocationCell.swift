import Declayout

final class ListLocationCell: UITableViewCell {
    
    private lazy var locationView = LocationListView.make {
        $0.edges(to: contentView)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        subViews()
    }
    
    required init?(coder Decoder: NSCoder) {
        super.init(coder: Decoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        contentView.addSubview(locationView)
    }
}
