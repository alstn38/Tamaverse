//
//  DIContainer.swift
//  Tamaverse
//
//  Created by 강민수 on 2/22/25.
//

import Foundation

final class DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    private var services: [String: AnyObject] = [:]

    func register<T>(type: T.Type, component: AnyObject) {
        let key = "\(type)"
        services[key] = component
    }
    
    func resolve<T>(type: T.Type) -> T {
        let key = "\(type)"
        return services[key] as! T
    }
}
