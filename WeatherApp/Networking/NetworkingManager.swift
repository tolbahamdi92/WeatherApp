//
//  NetworkingManager.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/15/23.
//

import Foundation
import Combine

//MARK: - APIError
enum APIError: LocalizedError {
    case requestNotFormed
    
    var errorDescription: String? {
        switch self {
        case .requestNotFormed: return Errors.requestError
        }
    }
}

struct NetworkingManager {
    
    //MARK: - Properties
    static let shared = NetworkingManager()
    
    //MARK: - Initializer
    private init(){}
}

//MARK: - Data Function
extension NetworkingManager {
    func requestAPI<T: Decodable>(city: String) -> AnyPublisher<T, APIError> {
        var components = URLComponents(string: WebServiceConstants.baseURL)!
        components.queryItems = [
            URLQueryItem(name: WebServiceConstants.key, value: WebServiceConstants.appKey),
            URLQueryItem(name: WebServiceConstants.qParamKey, value: city),
            URLQueryItem(name: WebServiceConstants.daysParamKey, value: WebServiceConstants.daysValue)
        ]
     
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.0 }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { _ in Fail(error: APIError.requestNotFormed).eraseToAnyPublisher()}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
