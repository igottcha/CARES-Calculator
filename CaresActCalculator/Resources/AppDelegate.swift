//
//  AppDelegate.swift
//  CaresActCalculator
//
//  Created by Chris Gottfredson on 4/6/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let nav1 = UINavigationController(rootViewController: CaresCalcViewController())
        let navigationBarAppearance = UINavigationBar.appearance()
        nav1.viewControllers = [CaresCalcViewController()]
        navigationBarAppearance.barTintColor = UIColor(named: "redColor")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav1
        window?.makeKeyAndVisible()
        return true
    }
}

