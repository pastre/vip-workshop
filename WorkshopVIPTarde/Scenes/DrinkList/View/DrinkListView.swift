import UIKit

final class DrinkListView: UIView {
    
    private var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DrinkCategoryCell.self)
        return view
    }()
    
    private lazy var drinksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DrinkCell.self, forCellWithReuseIdentifier: "DrinkCell")
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return view
    }()
  
    init(categoriesDataSource: UICollectionViewDataSource,
         categoriesDelegate: UICollectionViewDelegate,
         drinksCollectionViewDataSource: UICollectionViewDataSource,
         drinksCollectionViewDelegate: UICollectionViewDelegate
    ) {
        super.init(frame: .zero)
        categoriesCollectionView.delegate = categoriesDelegate
        categoriesCollectionView.dataSource = categoriesDataSource
        
        drinksCollectionView.dataSource = drinksCollectionViewDataSource
        drinksCollectionView.delegate = drinksCollectionViewDelegate
        
        
        setupCategoriesCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCategoriesCollectionView() {
        addSubview(categoriesCollectionView)
        addSubview(drinksCollectionView)
        
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: topAnchor),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 60),
            
            drinksCollectionView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor),
            drinksCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            drinksCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            drinksCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func reloadCategories() {
        categoriesCollectionView.reloadData()
    }
    
    func reloadDrinks() {
        drinksCollectionView.reloadData()
    }
}
