import UIKit

final class DrinkCell: UICollectionViewCell {
    private lazy var drinkImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var drinkNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(drinkImageView)
        contentView.addSubview(drinkNameLabel)
        NSLayoutConstraint.activate([
            drinkImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            drinkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            drinkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            drinkImageView.heightAnchor.constraint(equalToConstant: 100),
            drinkImageView.widthAnchor.constraint(equalToConstant: 100),
            
            drinkNameLabel.topAnchor.constraint(equalTo: drinkImageView.bottomAnchor),
            drinkNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            drinkNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            drinkNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(drinkName name: String, drinkImageUrl url: URL) {
        drinkNameLabel.text = name
        DispatchQueue.global().async {
            let imageData = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                self.drinkImageView.image = UIImage(data: imageData)
            }
        }
    }
}
