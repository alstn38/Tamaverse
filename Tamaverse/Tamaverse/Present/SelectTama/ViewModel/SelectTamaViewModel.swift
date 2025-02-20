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
        
    }
    
    struct Output {
        let tamagotchiInfo: Driver<[Tamagotchi]>
    }
    
    func transform(from input: Input) -> Output {
        
        return Output(
            tamagotchiInfo: BehaviorRelay(value: TamagotchiManager.allTamagotchi).asDriver()
        )
    }
}
