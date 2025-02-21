//
//  SceneDelegate.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navigationController = getRootNavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func getRootNavigationController() -> UINavigationController {
        let navigationController: UINavigationController
        let tamagotchiManager = TamagotchiManager()
        
        switch tamagotchiManager.isSelectedCharacter {
        case true:
            let viewController = GameViewController()
            navigationController = UINavigationController(rootViewController: viewController)
            
        case false:
            let viewModel = SelectTamaViewModel()
            let viewController = SelectTamaViewController(viewModel: viewModel)
            navigationController = UINavigationController(rootViewController: viewController)
        }
        
        return navigationController
    }
}
