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
        static let separatorText: String = "·"
        static let foodTextPlaceholder: String = "밥주세용"
        static let waterTextPlaceholder: String = "물주세용"
        static let foodButtonTitle: String = "밥먹기"
        static let waterButtonTitle: String = "물먹기"
    }
}
