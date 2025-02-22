//
//  UserInfoManager.swift
//  Tamaverse
//
//  Created by 강민수 on 2/22/25.
//

import Foundation
import RxSwift
import RxRelay

final class UserInfoManager {
    
    @UserDefault(key: UserInfoManagerKey.userName.key, defaultValue: "대장")
    private var userName: String
    private lazy var userNameRelay = BehaviorRelay(value: userName)
    
    var userNameObservable: Observable<String> {
        return userNameRelay.asObservable()
    }
    
    func updateUserName(with name: String) {
        userName = name
        userNameRelay.accept(name)
    }
}

// MARK: - UserInfoManager UserDefaults Key
extension UserInfoManager {
    
    enum UserInfoManagerKey: String {
        case userName
        
        var key: String {
            return rawValue
        }
    }
}
