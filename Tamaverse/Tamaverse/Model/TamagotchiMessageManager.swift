//
//  TamagotchiMessageManager.swift
//  Tamaverse
//
//  Created by 강민수 on 2/22/25.
//

import Foundation

struct TamagotchiMessageManager {
    
    private let replacingSign: String = "$"
    
    func getRandomMessage(name: String) -> String {
        let message = TamagotchiMessageManager.dummyMessage.randomElement()!
        return message.replacingOccurrences(of: replacingSign, with: name)
    }
}

// MARK: - TamagotchiMessageManager Dummy Message
// 메시지에 "$"는 닉네임이 들어갈 자리입니다.
// 닉네임이 아닌 용도로 사용하지 마세요.
extension TamagotchiMessageManager {
    
    static let dummyMessage: [String] = [
        "$님! 방금 뭐 하셨어요? 저랑 놀아줄 시간 아닌가요?",
        "복습 아직 안 하셨다구요? 지금 잠이 오세여? $님?",
        "$님, 저 배고픈 거 아니에요! …라고 말하고 싶지만 배고파요.",
        "우와~ $님, 먹이 주셨다! 진짜 최고예요. 이 맛에 키워집니다.",
        "$님, 저 오늘 기분이 좀 좋아요. 왜냐면… 그냥 $님이 최고니까요!",
        "설마… 저를 하루 종일 안 본 건 아니겠죠? $님, 저 삐질 거예요.",
        "$님, 오늘 하루 어땠어요? 저는… 솔직히 좀 심심했어요. (눈치 주는 중)",
        "어이, $님. 저를 이렇게 방치해도 되는 거예요? 감당 가능하시겠어요?",
        "오! $님이 만지셨다! 나 이제 VIP 대우 받는 거임?",
        "$님, 저한테 관심 좀 주세요. 관심은… 저의 비타민…",
        "오늘 하루도 수고했어요, $님. 저도… 아무것도 안 했지만 수고했어요!",
        "$님, 지금 뭐 먹고 있어요? 저도 한 입만… 아니면 두 입?",
        "$님이 저한테 먹이 주면, 저도 행복하고, $님도 행복하고, 세상이 평화롭고…",
        "헉! $님, 저 진짜 귀여운 거 아시죠? 아니면 지금 알게 되신 건가요?",
        "오늘도 $님 덕분에 잘 먹었습니다! 이제 운동은 $님이 하세요.",
        "$님, 저를 키우느라 힘드시죠? 하지만 이미 늦었어요. 책임지세요!",
        "$님, $님, $님! 그냥 부르고 싶었어요. 히히.",
        "$님, 오늘 하루 목표는 뭐예요? 저랑 놀아주는 것도 포함되겠죠?",
        "제가 너무 귀여워서 하루 종일 보고 싶으셨죠? $님? 인정하면 한 번 더 만지기!",
        "$님, 세상에서 제일 멋있어요. …이러면 간식 더 주실 거죠?"
    ]
}
