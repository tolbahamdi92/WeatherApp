//
//  ForecastCollectionCellVM.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/16/23.
//

import Foundation
import Combine

final class ForecastCollectionCellVM: ObservableObject {
    @Published var forecastDays: [Forecastday] = []
}

