//
//  SettingViewController.swift
//  Tamaverse
//
//  Created by 강민수 on 2/22/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SettingViewController: UIViewController {
    
    private let viewModel: SettingViewModel
    private let resetButtonDidTapRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    private let settingTableView = UITableView()
    
    init(viewModel: SettingViewModel) {
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
        let input = SettingViewModel.Input(
            viewDidLoad: Observable.just(()),
            settingCellDidTap: settingTableView.rx.modelSelected(SettingViewModel.SettingType.self).asObservable(),
            resetButtonDidTap: resetButtonDidTapRelay.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.settingArray
            .drive(settingTableView.rx.items(
                cellIdentifier: SettingTableViewCell.identifier,
                cellType: SettingTableViewCell.self
            )) { (row, element, cell) in
                cell.textLabel?.text = element.title
                cell.imageView?.image = UIImage(systemName: element.image)?.withRenderingMode(.alwaysTemplate)
                cell.imageView?.tintColor = UIColor(resource: .tamaFont)
                cell.accessoryType = .disclosureIndicator
                cell.backgroundColor = UIColor(resource: .tamaBackground)
                cell.selectionStyle = .none
                
                if case let .changeName(subTitle) = element {
                    cell.detailTextLabel?.text = subTitle
                }
            }
            .disposed(by: disposeBag)
        
        output.moveToOtherView
            .drive(with: self) { owner, type in
                switch type {
                case .changeName:
                    let viewModel = ChangeNameViewModel()
                    let viewController = ChangeNameViewController(viewModel: viewModel)
                    owner.navigationController?.pushViewController(viewController, animated: true)
                    
                case .changeCharacter:
                    let viewModel = SelectTamaViewModel()
                    let viewController = SelectTamaViewController(viewModel: viewModel)
                    owner.navigationController?.pushViewController(viewController, animated: true)
                    
                case .resetData:
                    guard
                        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                        let window = windowScene.windows.first
                    else { return }
                    
                    let viewModel = SelectTamaViewModel()
                    let viewController = SelectTamaViewController(viewModel: viewModel)
                    let navigationController = UINavigationController(rootViewController: viewController)
                    navigationController.view.alpha = 0.5
                    UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                        navigationController.view.alpha = 1.0
                    }
                    
                    window.rootViewController = navigationController
                }
            }
            .disposed(by: disposeBag)
        
        output.presentResetAlert
            .drive(with: self) { owner, _ in
                owner.presentDeleteAlert(
                    title: StringLiterals.Setting.delegateAlertTitle,
                    message: StringLiterals.Setting.delegateAlertMessage) {
                        owner.resetButtonDidTapRelay.accept(())
                    }
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigation() {
        navigationItem.title = StringLiterals.Setting.title
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .tamaBackground)
        
        settingTableView.rowHeight = 60
        settingTableView.backgroundColor = UIColor(resource: .tamaBackground)
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    
    private func configureHierarchy() {
        view.addSubview(settingTableView)
    }
    
    private func configureLayout() {
        settingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
