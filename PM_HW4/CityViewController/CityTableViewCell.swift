//
//  CityTableViewCell.swift
//  PM_HW4
//
//  Created by Admin on 1/22/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    let cityNameLabel = UILabel(title: "City", font: .systemFont(ofSize: 20))
    let weatherImageView = UIImageView(image: UIImage(named: "01d.png"))
    let temperatureLabel = UILabel(title: "+°", font: .systemFont(ofSize: 20))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureLabel)
        contentView.backgroundColor = .transparentBlack
        NSLayoutConstraint.activate([
            cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            temperatureLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),

            weatherImageView.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -20),
            weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
