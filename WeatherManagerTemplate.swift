//
//  WeatherManagerTemplate.swift
//  Clima

//import Foundation
//import CoreLocation
//protocol WeatherManagerDelegate {
//    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
//    //func dailyWeatherFetched(_ dailyItems: [Daily])
//    func didFailWithError(_ error: Error)
//}
//struct WeatherManager{
//    //http is not safe, use https
//    var delegate: WeatherManagerDelegate?
//
//    func fetchWeather(lat: String, long: String){
//        let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=hourly,minutely&appid=[PUT YOUR OWN API KEY]&units=metric"
//        performRequest(weatherURL)
//    }
//
//    func performRequest(_ urlString: String){
//        //1. Create a URL
//        if let url = URL(string: urlString){ //URL? optional due to possibility of typo
//            //2. create a URLSession
//            let session = URLSession(configuration: .default)
//
//            //3. give the session a task
//            //hit enter on the completionHandler to turn it to the closure
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil{
//                    //self.delegate?.didFailWithError(error!)
//                    return
//                }
//                //let strData = String(bytes: data!, encoding: .utf8)
//                //print(strData)
//                //if let is for safely unwrap the value
//                //print(jsonString)
//                if let safeData = data{
//
//                    if let weather = self.parseJSON(safeData){
//
//                        self.delegate?.didUpdateWeather(self, weather)
//                    }
//                }
//            }
//            //4. Start the task
//            task.resume()
//        }
//    }
//    // we need to parse JSON because the data when passing in is always a string and it's hard to read so this function is to analyze JSON
//    func parseJSON(_ weatherData: Data) -> WeatherModel? {
//        //inform how the data is structure
//        let decoder = JSONDecoder() //decode JSON
//        //add .self to reference the type, turn weatherdata into a data type that I am passing in
//        //catch error like try-except
//
//        //get data from the API (Very important step)
//        do{
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let id = decodedData.current.weather[0].id
//            let temp = decodedData.current.temp
//            let dailyList = decodedData.daily
//            let max = decodedData.daily[0].temp!.max
//            let min = decodedData.daily[0].temp!.min
//            let description = decodedData.current.weather[0].description
//            let weather = WeatherModel(conditionId: id, temperature: Double(temp),dailyArray: dailyList, maxTemp: max, minTemp: min, weatherDescription: description)
//
//            return weather
//        }catch{
//            self.delegate?.didFailWithError(error)
//            return nil
//        }
//    }
//}
//
