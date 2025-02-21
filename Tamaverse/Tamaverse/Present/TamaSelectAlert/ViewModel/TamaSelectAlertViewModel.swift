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
        let cancelButtonDidTap: Observable<Void>
        let confirmButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let tamagotchiInfo: Driver<Tamagotchi>
        let selectTamagotchi: Driver<Tamagotchi>
        let deSelectTamagotchi: Driver<Void>
    }
    
    private let tamagotchi: Tamagotchi
    private let disposeBag = DisposeBag()
    private let tamagotchiManager = TamagotchiManager()
    
    init(tamagotchi: Tamagotchi) {
        self.tamagotchi = tamagotchi
    }
    
    func transform(from input: Input) -> Output {
        let tamagotchiInfoRelay = BehaviorRelay(value: tamagotchi)
        let selectTamagotchiRelay = PublishRelay<Tamagotchi>()
        let deSelectTamagotchiRelay = PublishRelay<Void>()
        
        input.cancelButtonDidTap
            .bind(to: deSelectTamagotchiRelay)
            .disposed(by: disposeBag)
        
        input.confirmButtonDidTap
            .withUnretained(self)
            .map { $0.0.tamagotchi }
            .bind(to: selectTamagotchiRelay)
            .disposed(by: disposeBag)
        
        return Output(
            tamagotchiInfo: tamagotchiInfoRelay.asDriver(),
            selectTamagotchi: selectTamagotchiRelay.asDriver(onErrorJustReturn: TamagotchiManager.dummyModel(id: -1)),
            deSelectTamagotchi: deSelectTamagotchiRelay.asDriver(onErrorJustReturn: ())
        )
    }
}
