//
//  StringLiterals.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import Foundation

enum StringLiterals {
    
    enum Alert {
        static let confirm: String = "확인"
        static let cancel: String = "취소"
        static let delete: String = "삭제"
    }
    
    enum SelectTama {
        static let selectTitle: String = "다마고치 선택하기"
        static let changeTitle: String = "다마고치 변경하기"
        static let cancelButtonTitle: String = "취소"
        static let startButtonTitle: String = "시작하기"
        static let changeButtonTitle: String = "변경하기"
        static let changeAlertTitle: String = "변경 완료"
        static let changeAlertMessage: String = "다마고치가 변경되었습니다."
    }
    
    enum Game {
        static let title: String = "님의 다마고치"
        static let separatorText: String = "·"
        static let foodTextPlaceholder: String = "밥주세용"
        static let waterTextPlaceholder: String = "물주세용"
        static let foodButtonTitle: String = "밥먹기"
        static let waterButtonTitle: String = "물먹기"
        static let invalidCountTitle: String = "범위 오류"
        static let invalidFoodCountMessage: String = "입력 가능한 범위가 아닙니다. 1개 이상 50개 미만의 입력을 해주세요."
        static let invalidWaterCountMessage: String = "입력 가능한 범위가 아닙니다. 1개 이상 100개 미만의 입력을 해주세요."
        static let levelText: String = "LV "
        static let foodText: String = "밥알"
        static let waterText: String = "물방울"
        static let countText: String = "개"
    }
    
    enum Setting {
        static let title: String = "설정"
        static let delegateAlertTitle: String = "데이터 초기화"
        static let delegateAlertMessage: String = "정말 다시 처음부터 시작하시겠습니까?"
    }
}
