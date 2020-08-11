//
//  InfoViewController.swift
//  Clima

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var windInfo: UILabel!
    @IBOutlet weak var humidityInfo: UILabel!
    @IBOutlet weak var uvInfo: UILabel!
    @IBOutlet weak var dewInfo: UILabel!
    @IBOutlet weak var pressureInfo: UILabel!
    @IBOutlet weak var cloudsInfo: UILabel!
    
    //Variables to receive data from previous screen
    var windSpeed: String = ""
    var humidity: String = ""
    var uvIndex: String = ""
    var dewPoint: String = ""
    var pressure: String = ""
    var clouds: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 15
        windInfo.text = windSpeed
        humidityInfo.text = humidity
        uvInfo.text = uvIndex
        dewInfo.text = dewPoint
        pressureInfo.text = pressure
        cloudsInfo.text = clouds
    }
    


}
