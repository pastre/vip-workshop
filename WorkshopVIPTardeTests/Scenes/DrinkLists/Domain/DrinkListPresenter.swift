import XCTest

@testable import WorkshopVIPTarde

final class DrinkListPresenterTests: XCTestCase {
    
    private let spy = DrinkListViewControllerSpy()
    private lazy var sut: DrinkListPresenter = {
        let sut = DrinkListPresenter()
        sut.viewController = spy
        return sut
    }()
    
    func test_presentCategories_whenMappingToCurrentCategory_itShouldBeRed() {
        // Given
        let selectedItemIndex = 1
        let expectedColor = UIColor.red
        
        // When
        sut.presentCategories(.init(
            categories: ["a", "b", "c"],
            currentCategoryIndex: selectedItemIndex
        ))
        
        // Then
        let actualColor = spy.displayFiltersCategoriesPassed?[selectedItemIndex].color
        XCTAssertEqual(
            actualColor,
            expectedColor,
            "Selected item must be colored red"
        )
    }
    
    func test_presentCategories_whenMappingToUnselectedCategory_itShouldBeBlack() {
        // Given / When
        sut.presentCategories(.init(
            categories: ["a", "b", "c"],
            currentCategoryIndex: -1
        ))
        
        // Then
        XCTAssertTrue(spy.displayFiltersCategoriesPassed?.allSatisfy {
            $0.color == .black
        } ?? false)
    }
}

final class DrinkListViewControllerSpy: DrinkListDisplayLogic {
    private(set) var displayDrinksCallCount = 0
    func displayDrinks(_ viewModel: DrinkListSceneModel.ListDrinks.ViewModel) {
        displayDrinksCallCount += 1
    }
    
    private(set) var displayFiltersCallCount = 0
    private(set) var displayFiltersCategoriesPassed: [DrinkListSceneModel.Category]?
    func displayFilters(_ viewModel: DrinkListSceneModel.ListCategories.ViewModel) {
        displayFiltersCategoriesPassed = viewModel.categories
    }
}
