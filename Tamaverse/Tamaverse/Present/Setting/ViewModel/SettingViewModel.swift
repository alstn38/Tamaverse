//
//  SettingViewModel.swift
//  Tamaverse
//
//  Created by 강민수 on 2/23/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: InputOutputModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let settingCellDidTap: Observable<SettingType>
        let resetButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let settingArray: Driver<[SettingType]>
        let moveToOtherView: Driver<SettingType>
        let presentResetAlert: Driver<Void>
    }
    
    private let userInfoManager: UserInfoManager
    private let tamagotchiManager: TamagotchiManageable
    private let disposeBag = DisposeBag()
    
    init(
        userInfoManager: UserInfoManager = DIContainer.shared.resolve(type: UserInfoManager.self),
        tamagotchiManager: TamagotchiManageable = DIContainer.shared.resolve(type: TamagotchiManager.self)
    ) {
        self.userInfoManager = userInfoManager
        self.tamagotchiManager = tamagotchiManager
    }
    
    func transform(from input: Input) -> Output {
        let settingArrayRelay: BehaviorRelay<[SettingType]> = BehaviorRelay(value: [])
        let moveToOtherViewRelay = PublishRelay<SettingType>()
        let presentResetAlertRelay = PublishRelay<Void>()
        
        input.viewDidLoad
            .withLatestFrom(userInfoManager.userNameObservable)
            .map { [SettingType.changeName(subTitle: $0), SettingType.changeCharacter, SettingType.resetData] }
            .bind(to: settingArrayRelay)
            .disposed(by: disposeBag)
        
        input.settingCellDidTap
            .bind(with: self) { owner, type in
                switch type {
                case .changeName, .changeCharacter: moveToOtherViewRelay.accept(type)
                case .resetData: presentResetAlertRelay.accept(())
                }
            }
            .disposed(by: disposeBag)
        
        
        input.resetButtonDidTap
            .bind(with: self) { owner, _ in
                owner.userInfoManager.reset()
                owner.tamagotchiManager.reset()
                moveToOtherViewRelay.accept(.resetData)
            }
            .disposed(by: disposeBag)
        
        userInfoManager.userNameObservable
            .map { [SettingType.changeName(subTitle: $0), SettingType.changeCharacter, SettingType.resetData] }
            .bind(to: settingArrayRelay)
            .disposed(by: disposeBag)
        
        return Output(
            settingArray: settingArrayRelay.asDriver(),
            moveToOtherView: moveToOtherViewRelay.asDriver(onErrorJustReturn: .changeCharacter),
            presentResetAlert: presentResetAlertRelay.asDriver(onErrorJustReturn: ())
        )
    }
}

// MARK: - SettingView List Model
extension SettingViewModel {
    
    enum SettingType {
        case changeName(subTitle: String)
        case changeCharacter
        case resetData
        
        var title: String {
            switch self {
            case .changeName: return "내 이름 설정하기"
            case .changeCharacter: return "다마고치 변경하기"
            case .resetData: return "데이터 초기화"
            }
        }
        
        var image: String {
            switch self {
            case .changeName: return "pencil"
            case .changeCharacter: return "moon.fill"
            case .resetData: return "arrow.clockwise"
            }
        }
    }
}
