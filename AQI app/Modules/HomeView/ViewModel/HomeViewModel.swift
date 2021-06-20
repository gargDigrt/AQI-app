//
//  HomeViewModel.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import Foundation

protocol AQIRefreshDelegate: class {
    func refreshAQIdata(cities: [CityViewModel])
}

class HomeViewModel {
    
    //MARK:- Properties
    weak var refreshDelegate: AQIRefreshDelegate?
    var socketManager: SocketManager!
    
    //MARK:- Initializer
    
    
    /// At the time of initialization, this will initialize the SocketManager as well.
    init() {
        socketManager = SocketManager()
        socketManager.aqiDelegate = self
        socketManager.initialize()
    }
    
}

//MARK:- AQIUpdateDelegate

extension HomeViewModel: AQIUpdateDelegate {
    
    func didReceiveUpdates(_ cities: [City]) {
        guard cities.count>0 else {return}
        let allCities = cities.map({CityViewModel($0)})
        refreshDelegate?.refreshAQIdata(cities: allCities)
    }
}
