//
//  HomeViewController.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import UIKit

protocol CityAQIUpdateDelegate: class {
    func didReceiveCityAQIUpdate(cities: [CityViewModel])
}

class HomeViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet var cityTableView: UITableView!
    
    //Properties
    weak var cityUpdateDelegate: CityAQIUpdateDelegate?
    var cities: [CityViewModel] = []
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set refresh delegate for AQI updates
        homeViewModel.refreshDelegate = self
        
        cityTableView.accessibilityIdentifier = "table--cityListTableView"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide the navigation bar
        self.navigationController?.navigationBar.isHidden = true
    }
}


//MARK:- AQIRefreshDelegate
extension HomeViewController: AQIRefreshDelegate {
    
    func refreshAQIdata(cities: [CityViewModel]) {
        self.cities = cities
        DispatchQueue.main.async {
            self.cityTableView.reloadData()
        }
        guard cityUpdateDelegate != nil else {return}
        cityUpdateDelegate?.didReceiveCityAQIUpdate(cities: cities)
    }
}

//MARK:- UITableView Deleagte & Datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoViewCell.identifier, for: indexPath) as? CityInfoViewCell else {
            fatalError("Couldn't dequeue cell info cell")
        }
        let cityVM = self.cities[indexPath.row]
        cell.cityVM = cityVM
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityVM = self.cities[indexPath.row]
        guard let detailVC = storyboard?.instantiateViewController(identifier: DetailsViewController.identifier, creator: { coder in
            return DetailsViewController(coder: coder, selectedCity: cityVM)
        }) else {
            fatalError("Failed to load DetailsViewController from storyboard.")
        }
        
        cityUpdateDelegate = detailVC
        DispatchQueue.main.async {
            self.navigationController?.show(detailVC, sender: nil)
        }
    }
    
}

