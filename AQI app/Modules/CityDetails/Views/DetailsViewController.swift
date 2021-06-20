//
//  DeatilsViewController.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import UIKit
import Charts

class DetailsViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet var lineChartView: LineChartView!
    @IBOutlet var aqiStatusLabel: UILabel!
    @IBOutlet var aqiIndexLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var indexView: UIView!
    
    //Properties
    private var chartData: [ChartDataEntry] = []
    private var selectedCity: CityViewModel! {
        didSet {
            DispatchQueue.main.async{
                self.aqiIndexLabel.text = self.selectedCity.aqiValue
                self.aqiStatusLabel.text = self.selectedCity.aqiStatus
                self.cityNameLabel.text = self.selectedCity.name
                self.indexView.backgroundColor = self.selectedCity.aqiColor
            }
        }
    }
    
    
    //MARK:- View's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //Dependancy Injection
    init?(coder: NSCoder, selectedCity: CityViewModel) {
        self.selectedCity = selectedCity
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with CityViewModel.")
    }

}

//MARK:- CityAQIUpdateDelegate
extension DetailsViewController: CityAQIUpdateDelegate {
    func didReceiveCityAQIUpdate(cities: [CityViewModel]) {
        guard let cityUpdate = cities.filter({$0.name == selectedCity.name}).first else {return}
        print("City AQI update")
        print("===>",cityUpdate.aqiValue)
        selectedCity = cityUpdate
    }
}

//MARK:- ChartViewDelegate
extension DetailsViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}



