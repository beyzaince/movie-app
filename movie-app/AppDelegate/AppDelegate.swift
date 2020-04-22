//
//  AppDelegate.swift
//  movie-app
//
//  Created by beyza on 21.04.2020.
//  Copyright © 2020 beyza-ince. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    fileprivate let navigationCtrl = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
        createWindow()
        
        showMainView()
        
        return true
        
    }
    
    func createWindow() {
        let screenSize = UIScreen.main.bounds
        self.window = UIWindow(frame: screenSize)
        self.window?.rootViewController = navigationCtrl
        self.window?.makeKeyAndVisible()
        
    }
    
    func showMainView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVc: MovieListViewController = storyboard.instantiateInitialViewController() as! MovieListViewController
        navigationCtrl.pushViewController(mainVc, animated: false)
    }
    
    
}

