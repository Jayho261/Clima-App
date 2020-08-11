// This file is to set the cell of the table view

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Remove the highlight color when tap on the cell
    override func didMoveToSuperview() {
        selectionStyle = .none
    }
    
    //Create a setCell function here that put the data to the table view cell labels and imageviews
    func setCell(_ item: Daily?){
        if let dailyWeather = item{
            
            //convert date to string
            let time = Date(timeIntervalSince1970: TimeInterval(dailyWeather.dt!))
            let f = DateFormatter()
            f.dateFormat = "EEEE"
            let day = f.string(from: time)
            dateLabel.text = day
            
            tempLabel.text = String(format: "%.0f", dailyWeather.temp!.day) + "°C"
            
            let conditionId = dailyWeather.weather![0].id
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
            
            conditionImageView.image = UIImage(systemName: conditionName)
            
            
        }
        
       
    }
}
