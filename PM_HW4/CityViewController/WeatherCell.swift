//
//  WeatherCell.swift
//  PM_HW4
//
//  Created by Admin on 1/19/21.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    static var cellID = "WeatherCell"
    
    let dayLabel = UILabel(title: "--/--", font: .systemFont(ofSize: 14))
    let minTemperatureLabel = UILabel(title: "-°", font: .systemFont(ofSize: 20))
    let maxTemperatureLabel = UILabel(title: "+°", font: .systemFont(ofSize: 20))
    let weatherImageView = UIImageView(image: UIImage(named: "01d.png"))
    let humidityLabel = UILabel(title: "-%", font: .systemFont(ofSize: 12))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .black
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dayLabel)
        contentView.addSubview(minTemperatureLabel)
        contentView.addSubview(maxTemperatureLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(humidityLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            maxTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            maxTemperatureLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 8),
            
            minTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            minTemperatureLabel.topAnchor.constraint(equalTo: maxTemperatureLabel.bottomAnchor, constant: 8),
            
            weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImageView.topAnchor.constraint(equalTo: minTemperatureLabel.bottomAnchor, constant: 8),
            weatherImageView.widthAnchor.constraint(equalToConstant: 30),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1),
            
            humidityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            humidityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
}
 
