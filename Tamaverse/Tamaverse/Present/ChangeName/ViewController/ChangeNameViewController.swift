//
//  ChangeNameViewController.swift
//  Tamaverse
//
//  Created by 강민수 on 2/23/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ChangeNameViewController: UIViewController {
    
    private let viewModel: ChangeNameViewModel
    private let disposeBag = DisposeBag()
    private let saveButton = UIBarButtonItem()
    private let nickNameTextField = UITextField()
    private let lineView = UIView()
    
    init(viewModel: ChangeNameViewModel) {
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
    
    private func configureBind() {
        let input = ChangeNameViewModel.Input(
            nickNameTextFieldDidChange: nickNameTextField.rx.text.orEmpty.asObservable(),
            saveButtonDidTap: saveButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.userNickName
            .map { $0 + StringLiterals.ChangeName.navigationTitle }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.presentAlert
            .drive(with: self) { owner, value in
                let (title, message) = value
                owner.presentAlert(title: title, message: message)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigation() {
        saveButton.title = StringLiterals.ChangeName.saveButtonTitle
        saveButton.style = .plain
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .tamaBackground)
        
        nickNameTextField.placeholder = StringLiterals.ChangeName.nickNameTextFieldPlaceholder
        nickNameTextField.font = .systemFont(ofSize: 15, weight: .regular)
        nickNameTextField.textColor = UIColor(resource: .tamaFont)
        
        lineView.backgroundColor = UIColor(resource: .tamaFont)
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            nickNameTextField,
            lineView
        )
    }
    
    private func configureLayout() {
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(50)
            $0.height.equalTo(34)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(2)
            $0.horizontalEdges.equalTo(nickNameTextField)
            $0.height.equalTo(1)
        }
    }
}
