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
    @IBOutlet var updationTimeLbl: UILabel!
    @IBOutlet var indexView: UIView!
    @IBOutlet var chartContainerView: UIView!
    
    //Properties
    private var updateTimer: Timer!
    private var secondsCount = 0
    private var chartData: [ChartDataEntry] = []
    private var selectedCity: CityViewModel! {
        didSet {
            DispatchQueue.main.async{
                self.aqiIndexLabel.text = self.selectedCity.aqiValue
                self.aqiStatusLabel.text = self.selectedCity.aqiStatus
                self.aqiStatusLabel.textColor = self.selectedCity.aqiColor
                self.cityNameLabel.text = self.selectedCity.name
                self.indexView.backgroundColor = self.selectedCity.aqiColor
                self.aqiIndexLabel.layer.addCornerRadiusShadow()
                self.lineChartView.backgroundColor = self.selectedCity.aqiColor
                self.updationTimeLbl.text = JUST_NOW
                self.setDataToChart()
            }
        }
    }
    
    
    //MARK:- View's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Line Chart's basic setup
        chartViewInitialSetup()
        
        // Adding shadow to views
        indexView.layer.addCornerRadiusShadow(cornerRadiusValue: 15)
        chartContainerView.layer.addCornerRadiusShadow(cornerRadiusValue: 30)
        
        DispatchQueue.main.async {
            self.setDataToChart()
        }
        
    }
    
    
    //Dependancy Injection
    init?(coder: NSCoder, selectedCity: CityViewModel) {
        self.selectedCity = selectedCity
        super.init(coder: coder)
        if let newValue = Int(selectedCity.aqiValue) {
            self.addEntryToChartData(value: newValue)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with CityViewModel.")
    }
    
    //MARK:- Button Actions
    @IBAction func backButtonTapped(_ : UIButton) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK:- Other Behaviours
    
    
    /// This configures the chart view
    private func chartViewInitialSetup() {
        lineChartView.backgroundColor = selectedCity.aqiColor
        lineChartView.rightAxis.enabled = false
        let yAxis = lineChartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChartView.xAxis.setLabelCount(6, force: false)
        lineChartView.xAxis.labelTextColor = .white
        lineChartView.xAxis.axisLineColor = .white
    }
    
    
    /// This will add new entry to existing chart input data
    /// - Parameter value: New entry item of type "Int"
    private func addEntryToChartData(value: Int) {
        let index = chartData.count
        let dataEntry = ChartDataEntry(x:Double(index) ,y: Double(value))
        chartData.append(dataEntry)
    }
    
    
    /// This adds data to chart for display
    private func setDataToChart() {
        let lastUpdates = Array(chartData.suffix(30))
        let set = LineChartDataSet(entries: lastUpdates, label: "AQI")
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.setColor(.white)
        set.fillColor = .white
        set.fillAlpha = 0.8
        set.drawFilledEnabled = true
        set.drawCirclesEnabled = false
        set.drawHorizontalHighlightIndicatorEnabled = true
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    
    /// This count the seconds spent
    /// Also update the updation label
    @objc private func lastUpdate() {
        if secondsCount != 0 {
            DispatchQueue.main.async {
                self.updationTimeLbl.text = "Updated \(self.secondsCount) sec ago"
            }
        }
        secondsCount += 1
    }
    
    //MARK:- Deinitializer
    deinit {
        updateTimer.invalidate()
        updateTimer = nil
    }
}

//MARK:- CityAQIUpdateDelegate
extension DetailsViewController: CityAQIUpdateDelegate {
    
    func didReceiveCityAQIUpdate(cities: [CityViewModel]) {
        guard let cityUpdate = cities.filter({$0.name == selectedCity.name}).first else {return}
        if let newValue = Int(cityUpdate.aqiValue) {
            addEntryToChartData(value: newValue)
        }
        selectedCity = cityUpdate
        if updateTimer != nil {
            updateTimer.invalidate()
        }
        secondsCount = 0
        updateTimer = Timer(timeInterval: 0.01, target: self, selector: #selector(self.lastUpdate), userInfo: nil, repeats: true)
        updateTimer.fire()
    }
}




