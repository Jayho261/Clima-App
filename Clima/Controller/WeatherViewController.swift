import UIKit
import CoreLocation
class WeatherViewController: UIViewController{
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dailyButtonLabel: UIButton!
    
    var weatherManager = WeatherManager()
    var dailyWeatherArray: [Daily] = []
    var cityName: String = "None"
    var timer = Timer()
    let locationManager = CLLocationManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self //the text field should report back to the view controller
        weatherManager.delegate = self
        
        //Set up daily forecast button with icon and other stuffs
        dailyButtonLabel.layer.cornerRadius = 20
//        let forecastIcon = UIImage(named: "forecast")
//        dailyButtonLabel.setImage(forecastIcon, for: .normal)
//        dailyButtonLabel.imageView!.contentMode = .scaleAspectFit
//        dailyButtonLabel.imageView!.semanticContentAttribute = .forceRightToLeft //the image will be on the right side of the button
//        dailyButtonLabel.imageEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: -10) // the position of the image or icon
//        dailyButtonLabel.titleEdgeInsets = UIEdgeInsets(top:6, left: -90,bottom: 6, right: -220) //the position of the button title
        
        //Update the time continuously
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(updateLabel) , userInfo: nil, repeats: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func dailyButton(_ sender: UIButton) {
        performSegue(withIdentifier: "homeToForecast", sender: self)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation() //activate again
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let forecastVC = segue.destination as! ForecastViewController
        forecastVC.dailyForecastList = dailyWeatherArray
        forecastVC.location = cityName
    }
    
    @objc func updateLabel() {
        //Current time
        let time = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        timeLabel.text = dateFormatter.string(from: time)
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
}

//MARK: - UITextFielDelegate
extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    //this function is to tell the view controller when the user hit the return key. when return button get pressed. the blue key in the iphone keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true) //tell the system to dismiss the keyboard
        return true
    }
    // this function helps the view controller gets to decide what happens when the user tries to deselect the text field. It is useful for validation what the user typed
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            textField.placeholder = "Search"
            return true
        }else{
            textField.placeholder = "Type something"
            return false
        }
    }
    // this is equivalent to the text field saying, "Hey, view controller, the user stopped editing." Good to avoid repeated code
    func textFieldDidEndEditing(_ textField: UITextField) {
        // the code inside of this function will be execute when the iphone keyboard dissappears
        //optionally unwray the textfield text
        if let city = searchTextField.text{
            cityName = city
            getCoordinateFrom(address: cityName) { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                // don't forget to update the UI from the main thread
                DispatchQueue.main.async {
                    let cityLatitude = String(coordinate.latitude)
                    let cityLongitude = String(coordinate.longitude)
                    self.weatherManager.fetchWeather(lat: cityLatitude, long: cityLongitude)
                }
            }
        }
        //use the searchTextField.text to get the weather for that city
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel){
        //use DispatchQueue because complehandler runs for a long time and this helps to make it works faster
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString + "°C"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.backgroundView.image = UIImage(named: weather.conditionBackground)
            self.cityLabel.text = self.cityName
            self.maxLabel.text = "Max | " + weather.maxTempStr
            self.minLabel.text = "Min | " + weather.minTempStr
            self.descriptionLabel.text = weather.weatherDescription
            self.dailyWeatherArray = weather.dailyArray
            
        }
        
    }
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{//last item in the array
            locationManager.stopUpdatingLocation() //tell the location manager to stop
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            
            // This part is to convert the longitude and the latitude to the city name
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error{
                    print(error.localizedDescription)
                }
                if let placemarks = placemarks{
                    if placemarks.count > 0{
                        let placemark = placemarks[0]
                        if let city = placemark.locality{
                            //updated the cityName because after the app fetched the weather, it will call the didUpdateWeather() which will update the city label using the cityName variable
                            self.cityName = city
                            self.cityLabel.text = city
                        }
                    }
                }
            }
            weatherManager.fetchWeather(lat: lat, long: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
