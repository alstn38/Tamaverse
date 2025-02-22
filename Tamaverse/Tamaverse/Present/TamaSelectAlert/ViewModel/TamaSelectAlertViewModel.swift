//
//  TamaSelectAlertViewModel.swift
//  Tamaverse
//
//  Created by 강민수 on 2/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TamaSelectAlertViewModel: InputOutputModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let cancelButtonDidTap: Observable<Void>
        let confirmButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let selectModeTitle: Driver<String>
        let tamagotchiInfo: Driver<Tamagotchi>
        let selectTamagotchi: Driver<Tamagotchi>
        let deSelectTamagotchi: Driver<Void>
    }
    
    private let tamagotchi: Tamagotchi
    private let disposeBag = DisposeBag()
    private let tamagotchiManager: TamagotchiManageable
    
    init(
        tamagotchi: Tamagotchi,
        tamagotchiManager: TamagotchiManageable = DIContainer.shared.resolve(type: TamagotchiManager.self)
    ) {
        self.tamagotchi = tamagotchi
        self.tamagotchiManager = tamagotchiManager
    }
    
    func transform(from input: Input) -> Output {
        let selectModeTitleRelay = BehaviorRelay(value: "")
        let tamagotchiInfoRelay = BehaviorRelay(value: tamagotchi)
        let selectTamagotchiRelay = PublishRelay<Tamagotchi>()
        let deSelectTamagotchiRelay = PublishRelay<Void>()
        
        input.viewDidLoad
            .withUnretained(self)
            .map { $0.0.tamagotchiManager.isSelectedCharacter }
            .map { $0 ? StringLiterals.SelectTama.changeButtonTitle : StringLiterals.SelectTama.startButtonTitle }
            .bind(to: selectModeTitleRelay)
            .disposed(by: disposeBag)
        
        input.cancelButtonDidTap
            .bind(to: deSelectTamagotchiRelay)
            .disposed(by: disposeBag)
        
        input.confirmButtonDidTap
            .withUnretained(self)
            .map { $0.0.tamagotchi }
            .bind(to: selectTamagotchiRelay)
            .disposed(by: disposeBag)
        
        return Output(
            selectModeTitle: selectModeTitleRelay.asDriver(),
            tamagotchiInfo: tamagotchiInfoRelay.asDriver(),
            selectTamagotchi: selectTamagotchiRelay.asDriver(onErrorJustReturn: TamagotchiManager.dummyModel(id: -1)),
            deSelectTamagotchi: deSelectTamagotchiRelay.asDriver(onErrorJustReturn: ())
        )
    }
}
