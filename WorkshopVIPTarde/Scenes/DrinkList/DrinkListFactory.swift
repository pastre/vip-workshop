import UIKit

enum DrinkListFactory {
    static func make() -> UIViewController {
        
        let presenter = DrinkListPresenter()
        let interactor = DrinkListInteractor(presenter: presenter,
                                             worker: DrinkListWorker())
        let viewController = DrinkListViewController(interactor: interactor)
        
        presenter.viewController = viewController
        return viewController
    }
}
