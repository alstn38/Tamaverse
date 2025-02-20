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
        let tamagotchiDidSelect: Observable<Tamagotchi>
    }
    
    struct Output {
        let tamagotchiInfo: Driver<[Tamagotchi]>
        let moveToAlertView: Driver<Tamagotchi>
    }
    
    private let disposeBag = DisposeBag()
    private let tamagotchiManager = TamagotchiManager()
    
    func transform(from input: Input) -> Output {
        let moveToAlertViewRelay = PublishRelay<Tamagotchi>()
        
        input.tamagotchiDidSelect
            .withUnretained(self)
            .filter { $0.0.tamagotchiManager.isActiveCharacter(at: $0.1.id) }
            .map { $0.1 }
            .bind(to: moveToAlertViewRelay)
            .disposed(by: disposeBag)
        
        return Output(
            tamagotchiInfo: BehaviorRelay(value: TamagotchiManager.allTamagotchi).asDriver(),
            moveToAlertView: moveToAlertViewRelay.asDriver(onErrorJustReturn: TamagotchiManager.dummyModel(id: -1))
        )
    }
}
