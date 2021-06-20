//
//  CityInfoViewCell.swift
//  AQI app
//
//  Created by Vivek on 20/06/21.
//

import UIKit

class CityInfoViewCell: UITableViewCell {
    
    //MARK:- IBOutlet
    @IBOutlet var aqiStatusLabel: UILabel!
    @IBOutlet var aqiIndexLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var indexView: UIView!
    
    //Properties
    var cityVM: CityViewModel! {
        didSet{
            DispatchQueue.main.async{
                self.cityNameLabel.text = self.cityVM.name
                self.aqiStatusLabel.text = self.cityVM.aqiStatus
                self.aqiStatusLabel.textColor = self.cityVM.aqiColor
                self.aqiIndexLabel.text = self.cityVM.aqiValue
                self.indexView.backgroundColor = self.cityVM.aqiColor
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}



