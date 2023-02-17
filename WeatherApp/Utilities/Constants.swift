//
//  Constants.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/15/23.
//

import Foundation

//MARK: - WebServiceConstants
struct WebServiceConstants {
    static let baseURL = "https://api.weatherapi.com/v1/forecast.json"
    static let key = "key"
    static let http = "https:"
    static let appKey = "93768611bb1a4b50973181437231402"
    static let qParamKey = "q"
    static let defaultSearch = "Cairo"
    static let daysParamKey = "days"
    static let daysValue = "15"
}

//MARK: - Images
struct Images {
    static let sun = "sun.min.fill"
}

//MARK: - Storyboards
struct Storyboards {
    static let main = "Main"
}

//MARK: - ViewControllers
struct ViewControllers {
    static let detailVC = "DetailVC"
}

//MARK: - Cells
struct Cells {
    static let forcastCell = "ForeCastCollectionViewCell"
    static let hourCell = "HoursCollectionViewCell"
}

//MARK: - Date Format
struct DateFormat {
    static let dayName = "EEEE"
    static let time = "hh:mm"
}

//MARK: - HTTPMethodType
enum HTTPMethodType: String {
    case POST = "POST"
    case GET = "GET"
}

//MARK: - Errors
struct Errors {
    static let requestError = "Unable to form the request."
}

//MARK: - Alerts
struct Alerts {
    static let sorryTitle = "Sorry"
    static let successTitle = "Success"
    
    static let noSearchData = "please enter data in search"
    static let moreCharacterSearch = "please enter at least 3 characters"
    static let tryAgain = "Possibly something is wrong try again"
    
    static let disableLocation = "Your location is disable. \nPlease enable it"
    static let deniedLocationService = "I can not get location . \nI hope to accept access your location"
    
}
