import XCTest

@testable import WorkshopVIPTarde

final class DrinkListViewControllerTest: XCTestCase {
    
    // MARK: - Integration tests
    
    // This tests if the VIP scene is properly configures and cycles are running properly
    func test_whenViewAppears_itShouldLoadFilters() {
        // Given
        let workerStub = DrinkListWorkerStub()
        let adapterSpy = DrinkListFilterAdapterSpy()
        let presenter = DrinkListPresenter()
        let interactor = DrinkListInteractor(presenter: presenter,
                                             worker: workerStub)
        let sut = DrinkListViewController(
            interactor: interactor,
            categoriesAdapter: adapterSpy)
        
        presenter.viewController = sut
        
        workerStub.categoriesToUse = ["kkk"]
        
        // When
        
        _ = sut.view
        
        // Then
        XCTAssertEqual(adapterSpy.configureCallCount, 1)
    }
}

final class DrinkListFilterAdapterSpy: NSObject, DrinkListFilterAdapting {
    var didSelectCategoryAt: ((Int) -> Void)?
    
    
    private(set) var configureCallCount = 0
    
    func configure(categories: [DrinkListSceneModel.Category]) {
        configureCallCount += 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0 // NYI
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        .init() // NYI
    }
}

final class DrinkListWorkerStub: DrinkListWorkerProtocol {
    var delegate: DrinkListWorkerDelegate?
    
    var categoriesToUse: [String] = []
    var drinksToUse: [DrinkListSceneModel.Drink] = []
    
    func fetchCategories() {
        delegate?.didFetchCategories(categoriesToUse)
    }
    
    func fetchDrinks(forCategory category: String) {
        delegate?.didFetchDrinks(drinksToUse)
    }
}
