//
//  TamagotchiManager.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import Foundation

struct Tamagotchi {
    let name: String
    let profileImage: String
    let profileMessage: String
    let id: Int
}

struct TamagotchiManager {
    
    func isActiveCharacter(at id: Int) -> Bool {
        return [1, 2, 3].contains(id)
    }
}

extension TamagotchiManager {
    
    static var allTamagotchi: [Tamagotchi] {
        return [
            Tamagotchi(
                name: "따끔따끔 다마고치",
                profileImage: "1-6",
                profileMessage: "저는 따끔따끔 다마고치입니당! 가까이 오면 따끔할지도 몰라요~! 키는 120km! 몸무게는 180톤! 성격은 화끈하고, 가시처럼 단단하답니당! 매일매일 씩씩하게! 잘 먹고! 더 강해질 거예요! 따끔따끔!",
                id: 1
            ),
            Tamagotchi(
                name: "방실방실 다마고치",
                profileImage: "2-6",
                profileMessage: "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘먹고 잘 클 자신을 있답니당 방실방실!",
                id: 2
            ),
            Tamagotchi(
                name: "반짝반짝 다마고치",
                profileImage: "3-6",
                profileMessage: "저는 반짝반짝 다마고치입니당! 언제 어디서나 빛이 나요~! 키는 90km! 몸무게는 140톤! 성격은 반짝이는 별처럼 밝고, 날쌔게 움직인답니당! 오늘도 반짝반짝! 열심히 성장할 거예요! 기대해줘용!",
                id: 3
            ),
            TamagotchiManager.dummyModel(id: 4),
            TamagotchiManager.dummyModel(id: 5),
            TamagotchiManager.dummyModel(id: 6),
            TamagotchiManager.dummyModel(id: 7),
            TamagotchiManager.dummyModel(id: 8),
            TamagotchiManager.dummyModel(id: 9),
            TamagotchiManager.dummyModel(id: 10),
            TamagotchiManager.dummyModel(id: 11),
            TamagotchiManager.dummyModel(id: 12),
            TamagotchiManager.dummyModel(id: 13),
            TamagotchiManager.dummyModel(id: 14),
            TamagotchiManager.dummyModel(id: 15),
            TamagotchiManager.dummyModel(id: 16),
            TamagotchiManager.dummyModel(id: 17),
            TamagotchiManager.dummyModel(id: 18),
            TamagotchiManager.dummyModel(id: 19),
            TamagotchiManager.dummyModel(id: 10),
            TamagotchiManager.dummyModel(id: 21)
        ]
    }
    
    static func dummyModel(id: Int) -> Tamagotchi {
        return Tamagotchi(
            name: "준비중이에요",
            profileImage: "noImage",
            profileMessage: "",
            id: id
        )
    }
}
