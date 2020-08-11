//
//  WeatherData.swift
//  Clima
//
//This file is for the current weather structures

import Foundation
//Decodable protocol means that WeatherData can decode itself from an external representation
struct WeatherData: Codable{
    let current: Current
    let daily: [Daily]

}

struct Current: Codable{
    //let cloud: Int
    
    let temp: Double
    let weather: [Weather]
    
}
struct Weather: Codable{
    let description: String
    let id: Int
}
struct Daily: Codable{
    let dt: Int?
    let temp: Temp?
    let weather: [DailyWeather]?
    let feels_like: FeelLike?
    let pressure: Int?
    let humidity: Int?
    let wind_speed: Double?
    let dew_point: Double?
    let uvi: Double?
    let clouds: Int?
}

struct DailyWeather: Codable{
    let description: String
    let id: Int
}
struct Temp: Codable{
    let day: Double
    let night: Double
    let max: Double
    let min: Double
}
struct FeelLike: Codable{
    let day: Double
}
//make sure the property name match with the json data property name








