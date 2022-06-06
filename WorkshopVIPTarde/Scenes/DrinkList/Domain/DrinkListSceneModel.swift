import UIKit

enum DrinkListSceneModel {
    
    struct Category {
        let name: String
        let color: UIColor
    }
    
    struct Drink {
        let name: String
        let imageUrl: URL
    }
    
    enum ListCategories {
        struct Request {}
        struct Response {
            let categories: [String]
            let currentCategoryIndex: Int
        }
        struct ViewModel {
            let categories: [Category]
        }
    }
    
    enum SelectCategory {
        struct Request {
            let index: Int
        }
        struct Response {}
        struct ViewModel {}
    }
    
    enum ListDrinks {
        struct Request {}
        struct Response {
            let drinks: [Drink]
        }
        struct ViewModel {
            let drinks: [Drink]
        }
    }
}
