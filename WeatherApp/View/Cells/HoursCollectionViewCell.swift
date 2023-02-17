//
//  HoursCollectionViewCell.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/16/23.
//

import UIKit
import SDWebImage

class HoursCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties
    let dayTimePeriodFormatter = DateFormatter()
    
    //MARK: - Outlets
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    
    //MARK: - Life Cycle Cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK: - Configure Cell
extension HoursCollectionViewCell {
    func configureCell(for hour: Hour) {
        dayTimePeriodFormatter.dateFormat = DateFormat.time
        let date = Date(timeIntervalSince1970: Double(hour.timeEpoch))
        self.hourLabel.text = self.dayTimePeriodFormatter.string(from: date)
        self.conditionImageView.sd_setImage(with: URL(string: WebServiceConstants.http + hour.condition.icon), placeholderImage: UIImage(systemName: Images.sun))
        self.degreeLabel.text = "\(hour.tempC)º"
    }
}
