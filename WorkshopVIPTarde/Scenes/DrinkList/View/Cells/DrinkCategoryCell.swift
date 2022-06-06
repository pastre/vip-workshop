import UIKit

final class DrinkCategoryCell: UICollectionViewCell {
    private lazy var tagLabel: UILabel = {
        let view = UILabel()
        view.textColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tagLabel)
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(categoryName name: String, color: UIColor) {
        tagLabel.text = name
        tagLabel.textColor = color
    }
}
