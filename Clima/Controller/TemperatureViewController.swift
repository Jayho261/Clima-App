//
//  TemperatureViewController.swift
//  Clima

import UIKit

class TemperatureViewController: UIViewController {

    @IBOutlet weak var dayTemp: UILabel!
    @IBOutlet weak var nightTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var feelsLikeTemp: UILabel!
    var dayString: String = ""
    var nightString: String = ""
    var maxString: String = ""
    var minString: String = ""
    var feelsLikeString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        dayTemp.text = dayString
        nightTemp.text = nightString
        maxTemp.text = maxString
        minTemp.text = minString
        feelsLikeTemp.text = feelsLikeString
        view.layer.cornerRadius = 15
    }
    


}
