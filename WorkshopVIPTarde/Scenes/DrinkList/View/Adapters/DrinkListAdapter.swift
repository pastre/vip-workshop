import UIKit


final class DrinkListAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    typealias Drink = DrinkListSceneModel.Drink
    
    private var drinks: [Drink] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let drink = drinks[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrinkCell", for: indexPath)
        if let cell = cell as? DrinkCell {
            cell.configure(drinkName: drink.name, drinkImageUrl: drink.imageUrl)
        }
        return cell
    }
    
    func configure(using drinks: [Drink]) {
        self.drinks = drinks
    }
}
