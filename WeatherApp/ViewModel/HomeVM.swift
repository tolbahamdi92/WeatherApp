//
//  HomeVM.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/15/23.
//

import Combine
import Foundation

final class HomeVM: ObservableObject {
    
    //MARK: - Properties
    private var cancellableSet: Set<AnyCancellable> = []
    private let dayTimePeriodFormatter = DateFormatter()
    var collectionCellVM: ForecastCollectionCellVM
    
    //MARK: - Published Properties
    @Published var city: String = "Giza"
    @Published var day: String = ""
    @Published var degree: String = "25ºC"
    @Published var condition: String = "Cleary"
    @Published var humidity: String = "35º"
    @Published var imgUrl: String = ""
    
   //MARK: - Initializer
    init() {
        collectionCellVM = ForecastCollectionCellVM()
        requestData(city: city)
    }
}

//MARK: - Data function
extension HomeVM {
    func requestData(city: String) {
        dayTimePeriodFormatter.dateFormat = DateFormat.dayName
        let publisher: AnyPublisher<Weather, APIError> = NetworkingManager.shared.requestAPI(city: city)
        
        publisher.sink { error in
            if case let .failure(error) = error {
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] weather in
            guard let self = self else {return}
            self.imgUrl = weather.current.condition.icon
            let date = Date(timeIntervalSince1970: Double(weather.current.dateEpoch))
            self.day = self.dayTimePeriodFormatter.string(from: date)
            self.city = weather.location.name
            self.degree = "\(weather.current.tempC)º"
            self.condition = weather.current.condition.text
            self.humidity = "\(weather.current.humidity)º"
            self.collectionCellVM.forecastDays = weather.forecast.forecastday
        }
        .store(in: &cancellableSet)
    }
    
}
