//
//  SettingTableViewCell.swift
//  Tamaverse
//
//  Created by 강민수 on 2/23/25.
//

import UIKit

final class SettingTableViewCell: UITableViewCell, ReusableViewProtocol {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        detailTextLabel?.text = nil
    }
}
