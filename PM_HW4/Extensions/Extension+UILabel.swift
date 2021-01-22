//
//  Extension+UILabel.swift
//  PM_HW4
//
//  Created by Admin on 1/19/21.
//

import UIKit

extension UILabel {
    
    convenience init(title: String = "label",
                     font: UIFont = .systemFont(ofSize: 14),
                     textColor: UIColor = .white,
                     textAlignment: NSTextAlignment = .center) {
        
        self.init()
        self.text = title
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
