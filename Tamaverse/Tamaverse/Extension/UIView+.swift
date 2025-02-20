//
//  UIView+.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
