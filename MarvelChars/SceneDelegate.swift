//
//  SceneDelegate.swift
//  MarvelChars
//
//  Created by Angel Boullon on 15/06/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        setupNetworkManager()

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let viewController = buildInitialViewController()
        let rootNavigationViewController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = rootNavigationViewController
        window?.makeKeyAndVisible()
    }

    func buildInitialViewController() -> UIViewController {

        if let value = ProcessInfo.processInfo.environment["initialScene"] {
            
            switch value {
            case "CharDetail":
                let character = Character(id: 5,
                                          name: "Spiderman",
                                          description: "Description of Character Text")
                if let detailViewController = CharDetailConfigurator.createScene() as? CharDetailViewController {
                    detailViewController.presenter?.character = character
                    return detailViewController
                } else {
                    fallthrough
                }
            default:
                return CharListConfigurator.createScene()
            }
        }
        return CharListConfigurator.createScene()
    }

    func setupNetworkManager() {
        if let value = ProcessInfo.processInfo.environment["fakeData"], value == "yes" {
            ApiManager.sharedInstance.setFakeData(fakeData: true)
            
            if let jsonName = ProcessInfo.processInfo.environment["charactersServiceJsonName"] {
                ApiManager.sharedInstance.charactersService?.jsonName = jsonName
                ApiManager.sharedInstance.charactersService?.fakeResponse = .json
            }
            if ProcessInfo.processInfo.environment["charactersServiceError"] != nil {
                ApiManager.sharedInstance.charactersService?.networkError = .networkFailure
                ApiManager.sharedInstance.charactersService?.fakeResponse = .failure
            }
            
        } else {
            ApiManager.sharedInstance.setFakeData(fakeData: false)
            
            // UI Testing can configure baseURL
            if let baseURL = ProcessInfo.processInfo.environment["baseURL"] {
                ApiManager.baseURL = baseURL
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
