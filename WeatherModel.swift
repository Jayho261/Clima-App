//
//  WeatherModel.swift
//  Clima

import Foundation
struct WeatherModel{
    let conditionId: Int
    
    let temperature: Double
    
    //computed property
    var temperatureString: String{
        return String(format: "%.0f", temperature)
    }
    var maxTempStr: String{
        return String(format: "%.0f", maxTemp) + "°C"
    }
    var minTempStr: String{
        return String(format: "%.0f", minTemp) + "°C"
    }
    var dailyArray: [Daily] = []
    
    //Current max and min temperature
    let maxTemp: Double
    let minTemp: Double
    
    var conditionName: String{
        //get the weather name for the icon
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    var conditionBackground: String{
        switch conditionId {
        case 200...232:
            return "boltpic"
        case 300...321:
            return "drizzlepic1"
        case 500...531:
            return "rainingcity"
        case 600...622:
            return "snowpic1"
        case 701...781:
            return "foggy"
        case 800:
            return "clearsky"
        case 801...804:
            return "boltpic"
        default:
            return "cloudy"
        }
    }
    
    let weatherDescription: String
    
}
