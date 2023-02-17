//
//  ForeCastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/16/23.
//

import UIKit
import SDWebImage

class ForeCastCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    let dayTimePeriodFormatter = DateFormatter()
    
    //MARK: - Outlets
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var averageTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var backView: UIView!{
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    
    //MARK: - Life Cycle Cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK: - Configure Cell
extension ForeCastCollectionViewCell {
    func configureCell(for day: Forecastday) {
        dayTimePeriodFormatter.dateFormat = DateFormat.dayName
        let date = Date(timeIntervalSince1970: Double(day.dateEpoch))
        self.dayNameLabel.text = self.dayTimePeriodFormatter.string(from: date)
        self.conditionImageView.sd_setImage(with: URL(string: WebServiceConstants.http + day.day.condition.icon), placeholderImage: UIImage(systemName: Images.sun))
        self.averageTempLabel.text = "\(day.day.avgtempC)º"
        self.minTempLabel.text = "\(day.day.mintempC)º"
        self.maxTempLabel.text = "\(day.day.maxtempC)º"
    }
    
}
