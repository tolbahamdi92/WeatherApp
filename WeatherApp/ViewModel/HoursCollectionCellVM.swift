//
//  HoursCollectionCellVM.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/16/23.
//

import Foundation
import Combine

final class HoursCollectionCellVM: ObservableObject {
    @Published var hours: [Hour] = []
}
