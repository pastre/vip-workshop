import UIKit

protocol DrinkListFilterAdapting: UICollectionViewDelegate, UICollectionViewDataSource {
    var didSelectCategoryAt: ((Int) -> Void)? { get set }
    
    func configure(categories: [DrinkListSceneModel.Category])
}

final class DrinkListCategoriesAdapter: NSObject, DrinkListFilterAdapting {
    private var categories: [DrinkListSceneModel.Category] = []
    
    var didSelectCategoryAt: ((Int) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.item]
        let cell = collectionView.dequeue(DrinkCategoryCell.self, indexPath: indexPath)
        cell.configure(categoryName: category.name, color: category.color)
        return cell
    }
    
    func configure(categories: [DrinkListSceneModel.Category]) {
        self.categories = categories
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCategoryAt?(indexPath.item)
    }
}


extension UICollectionView {
    func dequeue<T>(_ type: T.Type, indexPath: IndexPath) -> T where T: UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath)
        guard let cell = cell as? T else {
            fatalError("No cell of type \(T.self) registered on collection view \(self)")
        }
        return cell
    }
    
    func register<T>(_ type: T.Type) where T: UICollectionViewCell {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }
}

extension NSObject {
    static var identifier: String { String(describing: self) }
}
