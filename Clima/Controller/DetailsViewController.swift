//
//  DetailsViewController.swift


import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayTitle: UILabel!
    //Weather details for a specific day
    var weatherDetails = Daily(dt: nil, temp: nil, weather: nil, feels_like: nil, pressure: nil, humidity: nil, wind_speed: nil, dew_point: nil, uvi: nil, clouds: nil)
    var dayName: String = ""
    var locationName: String = ""
    
    //Identifier names
    enum Segues{
        static let infoSegue = "toInfo"
        static let tempSegue = "toTemperature"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text = locationName
//        dayTitle.text = dayName + "'s Weather"
    }
    
    //Passing data to child view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //2 container views
        if segue.identifier == Segues.tempSegue{
            let tempVC = segue.destination as! TemperatureViewController
            if let dayVal = weatherDetails.temp?.day, let nightVal = weatherDetails.temp?.night, let maxVal = weatherDetails.temp?.max, let minVal = weatherDetails.temp?.min, let feelLikeVal = weatherDetails.feels_like?.day{
                tempVC.dayString = String(format: "%.0f", dayVal) + "°C"
                tempVC.nightString = String(format: "%.0f", nightVal) + "°C"
                tempVC.maxString = String(format: "%.0f", maxVal) + "°C"
                tempVC.minString = String(format: "%.0f", minVal) + "°C"
                tempVC.feelsLikeString = String(format: "%.0f", feelLikeVal) + "°C"
            }
        }
        else if segue.identifier == Segues.infoSegue{
            let infoVC = segue.destination as! InfoViewController
            if let windVal = weatherDetails.wind_speed, let humidVal = weatherDetails.humidity, let uvVal =  weatherDetails.uvi, let dewVal = weatherDetails.dew_point, let pressureVal = weatherDetails.pressure, let cloudsVal = weatherDetails.clouds{
                
                //Set all variables into a correct string format before transfer them
                let windString = String(format: "%.0f", windVal) + "m/s"
                let humidString = String(humidVal) + "%"
                let uvString = String(format: "%.0f", uvVal)
                let dewString = String(format: "%.0f", dewVal) + "°C"
                let pressureStr = String(pressureVal) + "hPA"
                let cloudString = String(cloudsVal) + "%"
                
                //Transfer data to the next screen
                infoVC.windSpeed = windString
                infoVC.humidity = humidString
                infoVC.uvIndex = uvString
                infoVC.dewPoint = dewString
                infoVC.pressure = pressureStr
                infoVC.clouds = cloudString
            }
        }
    }
}
