//
//  TamaSelectAlertViewController.swift
//  Tamaverse
//
//  Created by 강민수 on 2/21/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol TamaSelectAlertViewControllerDelegate: AnyObject {
    func viewController(_ viewController: UIViewController, didSelectCharacter item: Tamagotchi)
}

final class TamaSelectAlertViewController: UIViewController {
    
    private let viewModel: TamaSelectAlertViewModel
    private let disposeBag = DisposeBag()
    weak var delegate: TamaSelectAlertViewControllerDelegate?
    
    private let alertView = UIView()
    private let tamaImageView = UIImageView()
    private let tamaNameBackGroundView = UIView()
    private let tamaNameLabel = UILabel()
    private let lineView = UIView()
    private let tamaProfileMessageLabel = UILabel()
    private let buttonSeparatorLineView = UIView()
    private let cancelButton = UIButton()
    private let confirmButton = UIButton()
    
    init(viewModel: TamaSelectAlertViewModel) {
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
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureBind() {
        let input = TamaSelectAlertViewModel.Input(
            viewDidLoad: Observable.just(()),
            cancelButtonDidTap: cancelButton.rx.tap.asObservable(),
            confirmButtonDidTap: confirmButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.selectModeTitle
            .drive(confirmButton.rx.title())
            .disposed(by: disposeBag)
        
        output.tamagotchiInfo
            .drive(with: self) { owner, info in
                owner.configureView(info)
            }
            .disposed(by: disposeBag)
        
        output.selectTamagotchi
            .drive(with: self) { owner, tamagotchi in
                owner.dismiss(animated: false) {
                    owner.delegate?.viewController(owner, didSelectCharacter: tamagotchi)
                }
            }
            .disposed(by: disposeBag)
        
        output.deSelectTamagotchi
            .drive(with: self) { owner, _ in
                owner.dismiss(animated: false)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureView(_ tamagotchi: Tamagotchi) {
        tamaImageView.image = UIImage(named: tamagotchi.profileImage)
        tamaNameLabel.text = tamagotchi.name
        tamaProfileMessageLabel.text = tamagotchi.profileMessage
    }
    
    private func configureView() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        alertView.backgroundColor = UIColor(resource: .tamaBackground)
        alertView.layer.cornerRadius = 10
        alertView.clipsToBounds = true
        
        tamaNameBackGroundView.backgroundColor = UIColor(resource: .tamaFontBackground)
        tamaNameBackGroundView.layer.cornerRadius = 5
        tamaNameBackGroundView.layer.borderColor = UIColor(resource: .tamaFont).cgColor
        tamaNameBackGroundView.layer.borderWidth = 1
        
        tamaNameLabel.textColor = UIColor(resource: .tamaFont)
        tamaNameLabel.font = .systemFont(ofSize: 15, weight: .medium)
        tamaNameLabel.textAlignment = .center
        
        lineView.backgroundColor = UIColor(resource: .tamaFont)
        
        tamaProfileMessageLabel.textColor = UIColor(resource: .tamaFont)
        tamaProfileMessageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        tamaProfileMessageLabel.textAlignment = .center
        tamaProfileMessageLabel.numberOfLines = 5
        
        buttonSeparatorLineView.backgroundColor = UIColor(resource: .tamaFont).withAlphaComponent(0.2)
        
        cancelButton.setTitle(StringLiterals.SelectTama.cancelButtonTitle, for: .normal)
        cancelButton.setTitleColor(UIColor(resource: .tamaFont), for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        cancelButton.backgroundColor = .black.withAlphaComponent(0.1)
        
        confirmButton.setTitleColor(UIColor(resource: .tamaFont), for: .normal)
        confirmButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            alertView,
            tamaImageView,
            tamaNameBackGroundView,
            tamaNameLabel,
            lineView,
            tamaProfileMessageLabel,
            buttonSeparatorLineView,
            cancelButton,
            confirmButton
        )
    }
    
    private func configureLayout() {
        alertView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(450)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
        
        tamaImageView.snp.makeConstraints {
            $0.top.equalTo(alertView.snp.top).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(150)
        }
        
        tamaNameBackGroundView.snp.makeConstraints {
            $0.edges.equalTo(tamaNameLabel).inset(-6)
        }
        
        tamaNameLabel.snp.makeConstraints {
            $0.top.equalTo(tamaImageView.snp.bottom).offset(15)
            $0.height.equalTo(18)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(tamaNameBackGroundView.snp.bottom).offset(25)
            $0.height.equalTo(1)
            $0.horizontalEdges.equalTo(alertView).inset(40)
        }
        
        tamaProfileMessageLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(25)
            $0.horizontalEdges.equalTo(alertView).inset(40)
            $0.bottom.equalTo(buttonSeparatorLineView.snp.top).offset(-25)
        }
        
        buttonSeparatorLineView.snp.makeConstraints {
            $0.bottom.equalTo(cancelButton.snp.top)
            $0.height.equalTo(1)
            $0.horizontalEdges.equalTo(alertView)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.bottom.equalTo(alertView)
            $0.trailing.equalTo(view.snp.centerX)
            $0.height.equalTo(45)
        }
        
        confirmButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(alertView)
            $0.leading.equalTo(view.snp.centerX)
            $0.height.equalTo(45)
        }
    }
}
