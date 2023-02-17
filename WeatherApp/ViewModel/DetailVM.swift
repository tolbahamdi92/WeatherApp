//
//  DetailVM.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/16/23.
//

import Combine
import Foundation

final class DetailVM: ObservableObject {
    
    //MARK: - Properties
    var collectionCellVM: HoursCollectionCellVM
    private let dayTimePeriodFormatter = DateFormatter()
    
    //MARK: - Published Properties
    @Published var day: String = ""
    @Published var imgUrl: String = ""
    @Published var avgDegree: String = "25º"
    @Published var minDegree: String = "10º"
    @Published var maxDegree: String = "35º"
    
    //MARK: - Initializer
    init(forecastDay: Forecastday) {
        collectionCellVM = HoursCollectionCellVM()
        requestData(forecastDay: forecastDay)
    }
}

//MARK: - Data Function
extension DetailVM {
    func requestData(forecastDay: Forecastday) {
        dayTimePeriodFormatter.dateFormat = DateFormat.dayName
        let date = Date(timeIntervalSince1970: Double(forecastDay.dateEpoch))
        day = dayTimePeriodFormatter.string(from: date)
        imgUrl = forecastDay.day.condition.icon
        avgDegree = "\(forecastDay.day.avgtempC)º"
        minDegree = "\(forecastDay.day.mintempC)º"
        maxDegree = "\(forecastDay.day.maxtempC)º"
        collectionCellVM.hours = forecastDay.hour
        
    }
}
