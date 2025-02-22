//
//  GameViewController.swift
//  Tamaverse
//
//  Created by 강민수 on 2/21/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class GameViewController: UIViewController {
    
    private let viewModel: GameViewModel
    private let disposeBag = DisposeBag()
    private let viewWillAppearRelay = PublishRelay<Void>()
    private let tapGesture = UITapGestureRecognizer()
    
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
    private let textFieldBackgroundView = UIView()
    private let foodTextField = UITextField()
    private let foodTextFieldLineView = UIView()
    private let foodButton = UIButton()
    private let waterTextField = UITextField()
    private let waterTextFieldLineView = UIView()
    private let waterButton = UIButton()
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBind()
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearRelay.accept(())
    }
    
    private func configureBind() {
        let input = GameViewModel.Input(
            viewWillAppear: viewWillAppearRelay.asObservable(),
            profileButtonDidTap: profileButton.rx.tap.asObservable(),
            foodButtonDidTap: foodButton.rx.tap.withLatestFrom(foodTextField.rx.text.orEmpty).asObservable(),
            waterButtonDidTap: waterButton.rx.tap.withLatestFrom(waterTextField.rx.text.orEmpty).asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.titleText
            .map { $0 + StringLiterals.Game.title }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.characterMessage
            .drive(messageLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.characterImage
            .map { UIImage(named: $0) }
            .drive(characterImageView.rx.image)
            .disposed(by: disposeBag)
        
        output.characterName
            .drive(characterNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.characterLevel
            .map { StringLiterals.Game.levelText + String($0) }
            .drive(levelLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.foodCountText
            .map { StringLiterals.Game.foodText + String($0) + StringLiterals.Game.countText }
            .drive(foodCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.waterCountText
            .map { StringLiterals.Game.waterText + String($0) + StringLiterals.Game.countText }
            .drive(waterCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.moveToOtherView
            .drive(with: self) { owner, _ in
                let viewModel = SettingViewModel()
                let viewController = SettingViewController(viewModel: viewModel)
                owner.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.presentAlert
            .drive(with: self) { owner, value in
                let (title, message) = value
                owner.presentAlert(title: title, message: message)
            }
            .disposed(by: disposeBag)
        
        tapGesture.rx.event
            .bind(with: self) { owner, _ in
                owner.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigation() {
        profileButton.image = UIImage(systemName: "person.circle")
        profileButton.style = .plain
        
        navigationItem.rightBarButtonItem = profileButton
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .tamaBackground)
        view.addGestureRecognizer(tapGesture)
        
        messageImageView.image = UIImage(resource: .bubble)
        messageImageView.contentMode = .scaleToFill
        
        messageLabel.textColor = UIColor(resource: .tamaFont)
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        messageLabel.numberOfLines = 0
        
        characterNameBackGroundView.backgroundColor = UIColor(resource: .tamaFontBackground)
        characterNameBackGroundView.layer.cornerRadius = 5
        characterNameBackGroundView.layer.borderColor = UIColor(resource: .tamaFont).cgColor
        characterNameBackGroundView.layer.borderWidth = 1
        
        characterNameLabel.textColor = UIColor(resource: .tamaFont)
        characterNameLabel.textAlignment = .center
        characterNameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        infoStackView.axis = .horizontal
        infoStackView.spacing = 4
        infoStackView.alignment = .center
        infoStackView.distribution = .equalSpacing
        
        levelLabel.textColor = UIColor(resource: .tamaFont)
        levelLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        separatorLabel1.text = StringLiterals.Game.separatorText
        separatorLabel1.textColor = UIColor(resource: .tamaFont)
        separatorLabel1.font = .systemFont(ofSize: 18, weight: .bold)
        
        foodCountLabel.textColor = UIColor(resource: .tamaFont)
        foodCountLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        separatorLabel2.text = StringLiterals.Game.separatorText
        separatorLabel2.textColor = UIColor(resource: .tamaFont)
        separatorLabel2.font = .systemFont(ofSize: 18, weight: .bold)
        
        waterCountLabel.textColor = UIColor(resource: .tamaFont)
        waterCountLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        textFieldBackgroundView.backgroundColor = UIColor(resource: .tamaBackground)
        
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
            textFieldBackgroundView,
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
        
        textFieldBackgroundView.snp.makeConstraints {
            $0.top.equalTo(foodTextField.snp.top).offset(-4)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(waterTextField.snp.bottom).offset(14)
        }
        
        foodTextField.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(40).priority(.medium)
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalTo(view.snp.centerX).offset(30)
            $0.height.equalTo(34)
            $0.bottom.lessThanOrEqualTo(waterTextField.snp.top).offset(-15).priority(.high)
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
            $0.top.equalTo(foodTextField.snp.bottom).offset(15).priority(.medium)
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalTo(view.snp.centerX).offset(30)
            $0.height.equalTo(36)
            $0.bottom.lessThanOrEqualTo(view.keyboardLayoutGuide.snp.top).offset(-10).priority(.high)
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
