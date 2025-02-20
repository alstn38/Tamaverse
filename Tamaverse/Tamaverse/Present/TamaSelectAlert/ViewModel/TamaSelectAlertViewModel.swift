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
        
    }
    
    struct Output {
        let tamagotchiInfo: Driver<Tamagotchi>
    }
    
    private let tamagotchi: Tamagotchi
    
    init(tamagotchi: Tamagotchi) {
        self.tamagotchi = tamagotchi
    }
    
    func transform(from input: Input) -> Output {
        let tamagotchiInfoRelay = BehaviorRelay(value: tamagotchi)
        
        return Output(
            tamagotchiInfo: tamagotchiInfoRelay.asDriver()
        )
    }
}
