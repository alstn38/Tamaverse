//
//  ChangeNameViewModel.swift
//  Tamaverse
//
//  Created by 강민수 on 2/23/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ChangeNameViewModel: InputOutputModel {
    
    struct Input {
        let nickNameTextFieldDidChange: Observable<String>
        let saveButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let userNickName: Driver<String>
        let presentAlert: Driver<(title: String, message: String)>
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
        let presentAlertRelay = PublishRelay<(title: String, message: String)>()
        
        input.saveButtonDidTap
            .withLatestFrom(input.nickNameTextFieldDidChange)
            .bind(with: self) { owner, text in
                if text.count >= 2 && text.count <= 6 {
                    owner.userInfoManager.updateUserName(with: text)
                    presentAlertRelay.accept((
                        title: StringLiterals.ChangeName.successTitle,
                        message: StringLiterals.ChangeName.successMessage
                    ))
                } else {
                    presentAlertRelay.accept((
                        title: StringLiterals.ChangeName.faileTitle,
                        message: StringLiterals.ChangeName.faileMessage
                    ))
                }
            }
            .disposed(by: disposeBag)
            
        return Output(
            userNickName: userInfoManager.userNameObservable.asDriver(onErrorJustReturn: ""),
            presentAlert: presentAlertRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
}
