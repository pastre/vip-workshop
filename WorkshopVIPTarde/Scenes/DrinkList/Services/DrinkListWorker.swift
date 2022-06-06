//
//  DrinkListWorker.swift
//  WorkshopVIPTarde
//
//  Created by Bruno Pastre on 01/06/22.
//

import Foundation

protocol DrinkListWorkerDelegate: AnyObject {
    func didFetchCategories(_ categories: [String])
    func didFetchDrinks(_ drinks: [DrinkListSceneModel.Drink])
}

protocol DrinkListWorkerProtocol: AnyObject {
    var delegate: DrinkListWorkerDelegate? { get set }
    func fetchCategories()
    func fetchDrinks(forCategory category: String)
}

final class DrinkListWorker: DrinkListWorkerProtocol {
    
    weak var delegate: DrinkListWorkerDelegate?
    
    private let dispatchQueue: Dispatching
    private let session: URLSessionProtocol
    
    init(dispatchQueue: Dispatching = DispatchQueue.main,
         session: URLSessionProtocol = URLSession.shared
    ) {
        self.dispatchQueue = dispatchQueue
        self.session = session
    }
    
    func fetchCategories() {
        session.dataTask(
            with: .init(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list")!
        ) { [weak self] data, response, error in
            guard let data = data else {
                // TODO handle error
                return
            }
            do {
                let decoded = try JSONDecoder().decode(CategoriesResponseDTO.self, from: data)
                let categories = decoded.drinks.map { $0.category }
                self?.dispatchQueue.async {
                    self?.delegate?.didFetchCategories(categories)
                }
            } catch {}
        }
        .resume()
    }
    
    func fetchDrinks(forCategory category: String) {
        guard let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else { return }
        session.dataTask(
            with: .init(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(encodedCategory)")!
        ) { [weak self] data, response, error in
            guard let data = data else {
                // TODO handle error
                return
            }
            do {
                let decoded = try JSONDecoder().decode(DrinkListResponseDTO.self, from: data)
                self?.dispatchQueue.async {
                    self?.delegate?.didFetchDrinks(decoded.drinks.map {
                        .init(name: $0.name, imageUrl: $0.imageUrl)
                    })
                }
            } catch {}
        }
        .resume()
    }
}

protocol Dispatching {
    func async(_ work: @escaping () -> Void)
}

extension DispatchQueue: Dispatching {
    func async(_ work: @escaping () -> Void) {
        async(execute: work)
    }
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask(with: url, completionHandler: completionHandler)
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

// DTO -> Data transfer objects

private struct CategoriesResponseDTO: Codable {
    struct CategoryDTO: Codable {
        let category: String
        
        enum CodingKeys: String, CodingKey {
            case category = "strCategory"
        }
    }
    let drinks: [CategoryDTO]
}

private struct DrinkListResponseDTO: Codable  {
    struct DrinkDTO: Codable {
        let name: String
        let imageUrl: URL
        enum CodingKeys: String, CodingKey {
            case name = "strDrink"
            case imageUrl = "strDrinkThumb"
        }
    }
    
    let drinks: [DrinkDTO]
}
