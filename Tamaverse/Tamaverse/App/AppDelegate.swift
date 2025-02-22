//
//  AppDelegate.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNavigationBarAppearance()
        registerDIContainer()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
    
    private func configureNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(resource: .tamaBackground)
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(resource: .tamaFont),
            .font: UIFont.boldSystemFont(ofSize: 15)
        ]
        
        let appearance = UINavigationBar.appearance()
        appearance.standardAppearance = navigationBarAppearance
        appearance.scrollEdgeAppearance = navigationBarAppearance
        appearance.tintColor = UIColor(resource: .tamaFont)
    }
    
    private func registerDIContainer() {
        let container = DIContainer.shared
        container.register(type: TamagotchiManager.self, component: TamagotchiManager())
        container.register(type: UserInfoManager.self, component: UserInfoManager())
    }
}
