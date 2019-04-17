//
//  AppDelegate.swift
//
//  Created by Chuck Krutsinger on 2/1/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import UIKit
import CoreData
import CMUtilities
import RxSwift

@UIApplicationMain
  class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var appRouter: AppRouter?
    

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.makeKeyAndVisible()
        appRouter = AppRouter(window: window, appRouterState: Dependencies.appRouterState)
        
        return true
    }


}

