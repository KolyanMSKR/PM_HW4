//
//  Extension+UIStackView.swift
//  PM_HW4
//
//  Created by Admin on 1/19/21.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addBackgroundColor(color: UIColor) {
        let backgroundView = UIView(frame: bounds)
        backgroundView.backgroundColor = color
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(backgroundView, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}
