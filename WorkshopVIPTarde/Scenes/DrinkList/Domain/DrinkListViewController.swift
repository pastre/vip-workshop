//
//  ViewController.swift
//  WorkshopVIPTarde
//
//  Created by Bruno Pastre on 01/06/22.
//

import Foundation
import UIKit

protocol DrinkListDisplayLogic: AnyObject {
    func displayFilters(_ viewModel: DrinkListSceneModel.ListCategories.ViewModel)
    func displayDrinks(_ viewModel: DrinkListSceneModel.ListDrinks.ViewModel)
}

final class DrinkListViewController: UIViewController, DrinkListDisplayLogic {
    private let interactor: DrinkListInteractor
    private let categoriesAdapter: DrinkListFilterAdapting
    private let drinkListAdapter = DrinkListAdapter()
    
    private var drinkListView: DrinkListView? {
        view as? DrinkListView
    }
    
    init(interactor: DrinkListInteractor,
         categoriesAdapter: DrinkListFilterAdapting = DrinkListCategoriesAdapter()
    ) {
        self.interactor = interactor
        self.categoriesAdapter = categoriesAdapter
        super.init(nibName: nil, bundle: nil)
        
        categoriesAdapter.didSelectCategoryAt = {
            interactor.selectCategory(.init(index: $0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DrinkListView(
            categoriesDataSource: categoriesAdapter,
            categoriesDelegate: categoriesAdapter,
            drinksCollectionViewDataSource: drinkListAdapter,
            drinksCollectionViewDelegate: drinkListAdapter
        )
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        interactor.listCategories(.init())
    }
    
    func displayFilters(_ viewModel: DrinkListSceneModel.ListCategories.ViewModel) {
        categoriesAdapter.configure(categories: viewModel.categories)
        drinkListView?.reloadCategories()
    }
    
    func displayDrinks(_ viewModel: DrinkListSceneModel.ListDrinks.ViewModel) {
        drinkListAdapter.configure(using: viewModel.drinks)
        drinkListView?.reloadDrinks()
    }
}
