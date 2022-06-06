final class DrinkListInteractor: DrinkListWorkerDelegate {
    private let presenter: DrinkListPresenter
    private let worker: DrinkListWorkerProtocol
    
    private var categories: [String] = []
    private var currentCategoryIndex = 0
    
    init(presenter: DrinkListPresenter,
         worker: DrinkListWorkerProtocol
    ) {
        self.presenter = presenter
        self.worker = worker
        self.worker.delegate = self
    }
    
    func listCategories(_ request: DrinkListSceneModel.ListCategories.Request) {
        worker.fetchCategories()
    }
    
    func didFetchCategories(_ categories: [String]) {
        self.categories = categories
        fetchCurrentCategory()
        presenter.presentCategories(.init(
            categories: categories,
            currentCategoryIndex: currentCategoryIndex
        ))
    }
    
    func didFetchDrinks(_ drinks: [DrinkListSceneModel.Drink]) {
        presenter.presentDrinks(.init(drinks: drinks))
    }
    
    func selectCategory(_ request: DrinkListSceneModel.SelectCategory.Request) {
        currentCategoryIndex = request.index
        presenter.presentCategories(.init(
            categories: categories,
            currentCategoryIndex: currentCategoryIndex
        ))
        fetchCurrentCategory()
    }
    
    private func fetchCurrentCategory() {
        guard !categories.isEmpty
        else { return }
        let category = categories[currentCategoryIndex]
        worker.fetchDrinks(forCategory: category)
    }
}
