//
//  UIStackView+.swift
//  Tamaverse
//
//  Created by 강민수 on 2/21/25.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
