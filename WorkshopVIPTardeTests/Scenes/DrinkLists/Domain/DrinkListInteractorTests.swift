import XCTest

@testable import WorkshopVIPTarde

final class DrinkListInteractorTests: XCTestCase {
    private let spy = DrinkListWorkerSpy()
    private lazy var sut = DrinkListInteractor(
        presenter: .init(),
        worker: spy
    )
    
    // Whitebox test. Very intrusive and breaks some principles (coupled to code structure. If cateogories type's change, this will fail)
    func test_didFetchCategories_itShouldUpdateCategoryList() {
        // Given
        
        let expectedCategories = ["a", "b", "c"]
        
        // When
        
        sut.didFetchCategories(expectedCategories)
        
        // Then
        
        let mirror = Mirror(reflecting: sut)
        
        guard let actualCategories = mirror.children.first(where: { $0.label == "categories" })?.value as? [String]
        else { return XCTFail("Expected interactor to hold categories, but there's no array of strings in that object!") }
        XCTAssertEqual(actualCategories, expectedCategories)
    }
    
    func test_didFetchCategories_whenProperlyLoaded_itShouldFetchCurrentCategory() {
        // Given / When
        
        sut.didFetchCategories(["dummy"])
        
        // Then
        
        XCTAssertEqual(1, spy.fetchDrinksCallCount)
    }
    
    func test_didFetchCategories_whenCategoriesAreEmpty_itShouldNotFetch() {
        // Given / When
        
        sut.didFetchCategories([])
       
        // Then
        
        XCTAssertEqual(0, spy.fetchDrinksCallCount)
    }
}

final class DrinkListWorkerSpy: DrinkListWorkerProtocol {
    private(set) var fetchDrinksCallCount = 0
    func fetchDrinks(forCategory category: String) {
        fetchDrinksCallCount += 1
    }
    
    var delegate: DrinkListWorkerDelegate?
    
    func fetchCategories() {}
}

/*
 - Dummy objects are passed around but never actually used. Usually they are just used to fill parameter lists.
- Fake objects actually have working implementations, but usually take some shortcut which makes them not suitable for production (an InMemoryTestDatabase is a good example).
- Stubs provide canned answers to calls made during the test, usually not responding at all to anything outside what's programmed in for the test.
- Spies are stubs that also record some information based on how they were called. One form of this might be an email service that records how many messages it was sent.
- Mocks
 */
