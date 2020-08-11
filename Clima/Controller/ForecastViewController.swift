//
//  ForecastViewController.swift
//  Clima
//
//  Created by Jay Ho on 7/4/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    var dailyForecastList: [Daily] = []
    var location: String = ""
    @IBOutlet weak var forecastTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let indexPath = self.forecastTableView.indexPathForSelectedRow {
            forecastTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedDay = dailyForecastList[forecastTableView.indexPathForSelectedRow!.row]
        let detailsVC = segue.destination as! DetailsViewController
        detailsVC.weatherDetails = selectedDay
        let time = Date(timeIntervalSince1970: TimeInterval(selectedDay.dt!))
        let f = DateFormatter()
        f.dateFormat = "EEEE"
        let day = f.string(from: time)
        detailsVC.dayName = day
        detailsVC.locationName = location
        
        
    }
}

//MARK: - Forecast Table View Data Source
extension ForecastViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecastList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyForecastCell", for: indexPath) as! ForecastTableViewCell
        
        let dailyItem = dailyForecastList[indexPath.row]
        cell.setCell(dailyItem)
        return cell
    }


}
