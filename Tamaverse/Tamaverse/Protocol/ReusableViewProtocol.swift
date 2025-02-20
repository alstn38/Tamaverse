//
//  ReusableViewProtocol.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import Foundation

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
