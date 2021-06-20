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
    @IBOutlet var chartContainerView: UIView!
    
    //Properties
    private var chartData: [ChartDataEntry] = []
    private var selectedCity: CityViewModel! {
        didSet {
            DispatchQueue.main.async{
                self.aqiIndexLabel.text = self.selectedCity.aqiValue
                self.aqiStatusLabel.text = self.selectedCity.aqiStatus
                self.aqiStatusLabel.textColor = self.selectedCity.aqiColor
                self.cityNameLabel.text = self.selectedCity.name
                self.indexView.backgroundColor = self.selectedCity.aqiColor
                self.lineChartView.backgroundColor = self.selectedCity.aqiColor
                self.setDataToChart()
            }
        }
    }
    
    
    //MARK:- View's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        indexView.layer.applyCornerRadiusShadow(cornerRadiusValue: 15)
        chartContainerView.layer.applyCornerRadiusShadow(cornerRadiusValue: 50)
        
        setDataToChart()
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
    
    func addEntryToChartData(value: Int) {
        let index = chartData.count
        let dataEntry = ChartDataEntry(x:Double(index) ,y: Double(value))
        chartData.append(dataEntry)
    }
    
    func setDataToChart() {
        let lastUpdates = Array(chartData.suffix(30))
        let set = LineChartDataSet(entries: lastUpdates, label: "AQI")
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.setColor(.white)
        set.drawCirclesEnabled = false
        set.drawHorizontalHighlightIndicatorEnabled = true
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        lineChartView.data = data
    }
}

//MARK:- CityAQIUpdateDelegate
extension DetailsViewController: CityAQIUpdateDelegate {
    func didReceiveCityAQIUpdate(cities: [CityViewModel]) {
        guard let cityUpdate = cities.filter({$0.name == selectedCity.name}).first else {return}
        if let newValue = Int(cityUpdate.aqiValue) {
//            self.indexes.append(newValue)
            addEntryToChartData(value: newValue)
        }
        selectedCity = cityUpdate
    }
}

//MARK:- ChartViewDelegate
extension DetailsViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}



