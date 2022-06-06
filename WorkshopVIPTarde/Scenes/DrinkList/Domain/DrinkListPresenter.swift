final class DrinkListPresenter {
    weak var viewController: DrinkListDisplayLogic?
    
    func presentCategories(_ response: DrinkListSceneModel.ListCategories.Response) {
        viewController?.displayFilters(.init(categories: response.categories
            .enumerated()
            .map {
                .init(
                    name: $1,
                    color: $0 == response.currentCategoryIndex ? .red : .black
                )
            }
        ))
    }
    
    func presentDrinks(_ response: DrinkListSceneModel.ListDrinks.Response) {
        viewController?.displayDrinks(.init(drinks: response.drinks))
    }
}
