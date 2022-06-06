import XCTest

@testable import WorkshopVIPTarde

final class DrinkListWorkerTest: XCTestCase {
    func test_fetchCategories_whenApiRequestSucceeds_andDataIsParsed_itShouldCallDelegate() throws {
        // Given
        let dispatchFake = DispatchQueueFake()
        let urlSessionStub = URLSessionStub()
        let spy = DrinkListWorkerDelegateSpy()
        
        let sut = DrinkListWorker(
            dispatchQueue: dispatchFake,
            session: urlSessionStub
        )
        
        urlSessionStub.dataToUse = """
        {"drinks": []}
        """.data(using: .utf8)
        
        sut.delegate = spy
        
        // When
        sut.fetchCategories()
        
        // Then
        XCTAssertEqual(1, spy.didFetchCategoriesCallCount)
    }
}

final class DispatchQueueFake: Dispatching {
    func async(_ work: @escaping () -> Void) {
        work()
    }
}

final class URLSessionStub: URLSessionProtocol {
    var dataToUse: Data?
    var urlResponseToUse: URLResponse?
    var errorToUse: Error?
    func dataTask(with url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(dataToUse, urlResponseToUse, errorToUse)
        return URLSessionDataTaskDummy()
    }
}

struct URLSessionDataTaskDummy: URLSessionDataTaskProtocol {
    func resume() {}
}

final class DrinkListWorkerDelegateSpy: DrinkListWorkerDelegate {
    func didFetchDrinks(_ drinks: [DrinkListSceneModel.Drink]) {
        fatalError("NYI")
    }
    
    private(set) var didFetchCategoriesCallCount = 0
    func didFetchCategories(_ categories: [String]) {
        didFetchCategoriesCallCount += 1
    }
}
