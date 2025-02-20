//
//  TamaCollectionViewCell.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import UIKit
import SnapKit

final class TamaCollectionViewCell: UICollectionViewCell, ReusableViewProtocol {
    
    private let tamaImageView = UIImageView()
    private let tamaNameBackGroundView = UIView()
    private let tamaNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ tamagotchi: Tamagotchi) {
        tamaNameLabel.text = tamagotchi.name
        tamaImageView.image = UIImage(named: tamagotchi.profileImage)
    }
    
    private func configureView() {
        contentView.backgroundColor = UIColor(resource: .tamaBackground)
        
        tamaNameBackGroundView.backgroundColor = UIColor(resource: .tamaFontBackground)
        tamaNameBackGroundView.layer.cornerRadius = 5
        tamaNameBackGroundView.layer.borderColor = UIColor(resource: .tamaFont).cgColor
        tamaNameBackGroundView.layer.borderWidth = 1
        
        tamaNameLabel.text = "임시 타마고치" // TODO: 삭제
        tamaNameLabel.textColor = UIColor(resource: .tamaFont)
        tamaNameLabel.font = .systemFont(ofSize: 13, weight: .medium)
        tamaNameLabel.textAlignment = .center
    }
    
    private func configureHierarchy() {
        contentView.addSubviews(
            tamaImageView,
            tamaNameBackGroundView,
            tamaNameLabel
        )
    }
    
    private func configureLayout() {
        tamaImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(contentView.snp.width)
        }
        
        tamaNameBackGroundView.snp.makeConstraints {
            $0.edges.equalTo(tamaNameLabel).inset(-6)
        }
        
        tamaNameLabel.snp.makeConstraints {
            $0.top.equalTo(tamaImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
    }
}
