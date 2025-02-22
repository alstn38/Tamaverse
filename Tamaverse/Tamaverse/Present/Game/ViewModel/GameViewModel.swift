//
//  GameViewModel.swift
//  Tamaverse
//
//  Created by 강민수 on 2/22/25.
//

import Foundation
import RxSwift
import RxCocoa

final class GameViewModel: InputOutputModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let profileButtonDidTap: Observable<Void>
        let foodButtonDidTap: Observable<String>
        let waterButtonDidTap: Observable<String>
    }
    
    struct Output {
        let titleText: Driver<String>
        let characterMessage: Driver<String>
        let characterImage: Driver<String>
        let characterName: Driver<String>
        let characterLevel: Driver<Int>
        let foodCountText: Driver<Int>
        let waterCountText: Driver<Int>
        let moveToOtherView: Driver<Void>
        let presentAlert: Driver<(title: String, message: String)>
    }
    
    private let userInfoManager: UserInfoManager
    private let tamagotchiManager: TamagotchiManageable
    private let tamagotchiMessageManager = TamagotchiMessageManager()
    private let disposeBag = DisposeBag()
    
    init(
        userInfoManager: UserInfoManager = DIContainer.shared.resolve(type: UserInfoManager.self),
        tamagotchiManager: TamagotchiManageable = DIContainer.shared.resolve(type: TamagotchiManager.self)
    ) {
        self.userInfoManager = userInfoManager
        self.tamagotchiManager = tamagotchiManager
    }
    
    func transform(from input: Input) -> Output {
        let characterMessageRelay = BehaviorRelay(value: "")
        let moveToOtherViewRelay = PublishRelay<Void>()
        let presentAlertRelay = PublishRelay<(title: String, message: String)>()
        
        input.viewWillAppear
            .withLatestFrom(userInfoManager.userNameObservable)
            .withUnretained(self)
            .map { $0.0.tamagotchiMessageManager.getRandomMessage(name: $0.1) }
            .bind(to: characterMessageRelay)
            .disposed(by: disposeBag)
        
        input.profileButtonDidTap
            .bind(to: moveToOtherViewRelay)
            .disposed(by: disposeBag)
        
        input.foodButtonDidTap
            .map { Int($0) ?? 1 }
            .withLatestFrom(userInfoManager.userNameObservable) { ($0, $1) }
            .bind(with: self) { owner, value in
                let (count, name) = value
                guard count > 0 && count < 50 else {
                    presentAlertRelay.accept((
                        title: StringLiterals.Game.invalidCountTitle,
                        message: StringLiterals.Game.invalidFoodCountMessage
                    ))
                    return
                }
                
                let message = owner.tamagotchiMessageManager.getRandomMessage(name: name)
                characterMessageRelay.accept(message)
                owner.tamagotchiManager.addFoodCount(count)
            }
            .disposed(by: disposeBag)
        
        input.waterButtonDidTap
            .map { Int($0) ?? 1 }
            .withLatestFrom(userInfoManager.userNameObservable) { ($0, $1) }
            .bind(with: self) { owner, value in
                let (count, name) = value
                guard count > 0 && count < 100 else {
                    presentAlertRelay.accept((
                        title: StringLiterals.Game.invalidCountTitle,
                        message: StringLiterals.Game.invalidWaterCountMessage
                    ))
                    return
                }
                
                let message = owner.tamagotchiMessageManager.getRandomMessage(name: name)
                characterMessageRelay.accept(message)
                owner.tamagotchiManager.addWaterCount(count)
            }
            .disposed(by: disposeBag)
        
        return Output(
            titleText: userInfoManager.userNameObservable.asDriver(onErrorJustReturn: ""),
            characterMessage: characterMessageRelay.asDriver(),
            characterImage: tamagotchiManager.characterImageObservable.asDriver(onErrorJustReturn: ""),
            characterName: tamagotchiManager.characterNameObservable.asDriver(onErrorJustReturn: ""),
            characterLevel: tamagotchiManager.characterLevelObservable.asDriver(onErrorJustReturn: 0),
            foodCountText: tamagotchiManager.foodCountObservable.asDriver(onErrorJustReturn: 0),
            waterCountText: tamagotchiManager.waterCountObservable.asDriver(onErrorJustReturn: 0),
            moveToOtherView: moveToOtherViewRelay.asDriver(onErrorJustReturn: ()),
            presentAlert: presentAlertRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
}
