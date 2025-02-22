//
//  SelectTamaViewModel.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SelectTamaViewModel: InputOutputModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let tamagotchiDidSelect: Observable<Tamagotchi>
        let tamagotchiDidChange: Observable<Tamagotchi>
    }
    
    struct Output {
        let navigationTitle: Driver<String>
        let tamagotchiInfo: Driver<[Tamagotchi]>
        let moveToAlertView: Driver<Tamagotchi>
        let startGame: Driver<Void>
        let changeTamagotchi: Driver<Void>
    }
    
    private let disposeBag = DisposeBag()
    private var tamagotchiManager: TamagotchiManageable
    
    init(tamagotchiManager: TamagotchiManageable = DIContainer.shared.resolve(type: TamagotchiManager.self)) {
        self.tamagotchiManager = tamagotchiManager
    }
    
    func transform(from input: Input) -> Output {
        let navigationTitleRelay = BehaviorRelay(value: "")
        let moveToAlertViewRelay = PublishRelay<Tamagotchi>()
        let startGameRelay = PublishRelay<Void>()
        let changeTamagotchiRelay = PublishRelay<Void>()
        
        input.viewDidLoad
            .withUnretained(self)
            .map { $0.0.tamagotchiManager.isSelectedCharacter }
            .map { $0 ? StringLiterals.SelectTama.changeTitle : StringLiterals.SelectTama.selectTitle }
            .bind(to: navigationTitleRelay)
            .disposed(by: disposeBag)
        
        input.tamagotchiDidSelect
            .withUnretained(self)
            .filter { $0.0.tamagotchiManager.isActiveCharacter(at: $0.1.id) }
            .map { $0.1 }
            .bind(to: moveToAlertViewRelay)
            .disposed(by: disposeBag)
        
        input.tamagotchiDidChange
            .bind(with: self) { owner, tamagotchi in
                let isSelectedCharacter = owner.tamagotchiManager.isSelectedCharacter
                owner.tamagotchiManager.updateCurrentCharacter(at: tamagotchi.id)
                
                switch isSelectedCharacter {
                case true:
                    changeTamagotchiRelay.accept(())
                    
                case false:
                    startGameRelay.accept(())
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            navigationTitle: navigationTitleRelay.asDriver(),
            tamagotchiInfo: BehaviorRelay(value: TamagotchiManager.allTamagotchi).asDriver(),
            moveToAlertView: moveToAlertViewRelay.asDriver(onErrorJustReturn: TamagotchiManager.dummyModel(id: -1)),
            startGame: startGameRelay.asDriver(onErrorJustReturn: ()),
            changeTamagotchi: changeTamagotchiRelay.asDriver(onErrorJustReturn: ())
        )
    }
}
