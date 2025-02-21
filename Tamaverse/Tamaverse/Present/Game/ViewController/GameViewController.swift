//
//  GameViewController.swift
//  Tamaverse
//
//  Created by 강민수 on 2/21/25.
//

import UIKit
import SnapKit

final class GameViewController: UIViewController {
    
    private let profileButton = UIBarButtonItem()
    private let messageImageView = UIImageView()
    private let messageLabel = UILabel()
    private let characterImageView = UIImageView()
    private let characterNameBackGroundView = UIView()
    private let characterNameLabel = UILabel()
    private let infoStackView = UIStackView()
    private let levelLabel = UILabel()
    private let separatorLabel1 = UILabel()
    private let foodCountLabel = UILabel()
    private let separatorLabel2 = UILabel()
    private let waterCountLabel = UILabel()
    private let foodTextField = UITextField()
    private let foodTextFieldLineView = UIView()
    private let foodButton = UIButton()
    private let waterTextField = UITextField()
    private let waterTextFieldLineView = UIView()
    private let waterButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureNavigation() {
        navigationItem.title = "대장님의 다마고치" // TODO: 삭제
        profileButton.image = UIImage(systemName: "person.circle")
        profileButton.style = .plain
        
        navigationItem.rightBarButtonItem = profileButton
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .tamaBackground)
        
        messageImageView.image = UIImage(resource: .bubble)
        messageImageView.contentMode = .scaleToFill
        
        characterImageView.image = UIImage(resource: ._1_1) // TODO: 삭제
        
        messageLabel.text = "복습 아직 안하셨다구요? 지금 잠이 오세여? 대장님?" // TODO: 삭제
        messageLabel.textColor = UIColor(resource: .tamaFont)
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        messageLabel.numberOfLines = 0
        
        characterNameBackGroundView.backgroundColor = UIColor(resource: .tamaFontBackground)
        characterNameBackGroundView.layer.cornerRadius = 5
        characterNameBackGroundView.layer.borderColor = UIColor(resource: .tamaFont).cgColor
        characterNameBackGroundView.layer.borderWidth = 1
        
        characterNameLabel.text = "도레미파 다마고치" // TODO: 삭제
        characterNameLabel.textColor = UIColor(resource: .tamaFont)
        characterNameLabel.textAlignment = .center
        characterNameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        infoStackView.axis = .horizontal
        infoStackView.spacing = 4
        infoStackView.alignment = .center
        infoStackView.distribution = .equalSpacing
        
        levelLabel.text = "LV 1" // TODO: 삭제
        levelLabel.textColor = UIColor(resource: .tamaFont)
        levelLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        separatorLabel1.text = StringLiterals.Game.separatorText
        separatorLabel1.textColor = UIColor(resource: .tamaFont)
        separatorLabel1.font = .systemFont(ofSize: 18, weight: .bold)
        
        foodCountLabel.text = "밥알 0개" // TODO: 삭제
        foodCountLabel.textColor = UIColor(resource: .tamaFont)
        foodCountLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        separatorLabel2.text = StringLiterals.Game.separatorText
        separatorLabel2.textColor = UIColor(resource: .tamaFont)
        separatorLabel2.font = .systemFont(ofSize: 18, weight: .bold)
        
        waterCountLabel.text = "물방울 0개" // TODO: 삭제
        waterCountLabel.textColor = UIColor(resource: .tamaFont)
        waterCountLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        foodTextField.placeholder = StringLiterals.Game.foodTextPlaceholder
        foodTextField.font = .systemFont(ofSize: 15, weight: .regular)
        foodTextField.textColor = UIColor(resource: .tamaFont)
        foodTextField.textAlignment = .center
        foodTextField.keyboardType = .numberPad
        
        foodTextFieldLineView.backgroundColor = UIColor(resource: .tamaFont)
        
        foodButton.configuration = makeConfiguration(title: StringLiterals.Game.foodButtonTitle, systemImageName: "drop.circle")
        foodButton.layer.cornerRadius = 5
        foodButton.layer.borderWidth = 1
        foodButton.layer.borderColor = UIColor(resource: .tamaFont).cgColor
        foodButton.clipsToBounds = true
        
        waterTextField.placeholder = StringLiterals.Game.waterTextPlaceholder
        waterTextField.font = .systemFont(ofSize: 15, weight: .regular)
        waterTextField.textColor = UIColor(resource: .tamaFont)
        waterTextField.textAlignment = .center
        waterTextField.keyboardType = .numberPad
        
        waterTextFieldLineView.backgroundColor = UIColor(resource: .tamaFont)
        
        waterButton.configuration = makeConfiguration(title: StringLiterals.Game.foodButtonTitle, systemImageName: "leaf.circle")
        waterButton.layer.cornerRadius = 5
        waterButton.layer.borderWidth = 1
        waterButton.layer.borderColor = UIColor(resource: .tamaFont).cgColor
        waterButton.clipsToBounds = true
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            messageImageView,
            messageLabel,
            characterImageView,
            characterNameBackGroundView,
            characterNameLabel,
            infoStackView,
            foodTextField,
            foodTextFieldLineView,
            foodButton,
            waterTextField,
            waterTextFieldLineView,
            waterButton
        )
        
        infoStackView.addArrangedSubviews(
            levelLabel,
            separatorLabel1,
            foodCountLabel,
            separatorLabel2,
            waterCountLabel
        )
    }
    
    private func configureLayout() {
        messageImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(60)
            $0.height.equalTo(150)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(messageImageView).inset(10)
            $0.bottom.equalTo(messageImageView).inset(20)
        }
        
        characterImageView.snp.makeConstraints {
            $0.top.equalTo(messageImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200)
        }
        
        characterNameBackGroundView.snp.makeConstraints {
            $0.edges.equalTo(characterNameLabel).inset(-6)
        }
        
        characterNameLabel.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(characterNameBackGroundView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        foodTextField.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalTo(view.snp.centerX).offset(30)
            $0.height.equalTo(34)
        }
        
        foodTextFieldLineView.snp.makeConstraints {
            $0.top.equalTo(foodTextField.snp.bottom)
            $0.horizontalEdges.equalTo(foodTextField)
            $0.height.equalTo(1)
        }
        
        foodButton.snp.makeConstraints {
            $0.centerY.equalTo(foodTextField)
            $0.leading.equalTo(foodTextField.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(60)
            $0.height.equalTo(34)
        }
        
        waterTextField.snp.makeConstraints {
            $0.top.equalTo(foodTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalTo(view.snp.centerX).offset(30)
            $0.height.equalTo(36)
        }
        
        waterTextFieldLineView.snp.makeConstraints {
            $0.top.equalTo(waterTextField.snp.bottom)
            $0.horizontalEdges.equalTo(waterTextField)
            $0.height.equalTo(1)
        }
        
        waterButton.snp.makeConstraints {
            $0.centerY.equalTo(waterTextField)
            $0.leading.equalTo(waterTextField.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(60)
            $0.height.equalTo(36)
        }
    }
    
    private func makeConfiguration(title: String, systemImageName: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = .systemFont(ofSize: 15, weight: .bold)
        configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 10)
        configuration.preferredSymbolConfigurationForImage = imageConfiguration
        configuration.image = UIImage(systemName: systemImageName)
        configuration.baseBackgroundColor = UIColor(resource: .tamaBackground)
        configuration.baseForegroundColor = UIColor(resource: .tamaFont)
        configuration.imagePadding = 5
        configuration.titleAlignment = .leading
        
        return configuration
    }
}
