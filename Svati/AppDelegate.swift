//
//  AppDelegate.swift
//  Svati
//
//  Created by Petr Hracek on 17.07.2023.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SvatiDataService.shared.loadData()
        FirebaseApp.configure()
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.SvatiColor.darkGreenColor()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance().barTintColor =  UIColor.SvatiColor.darkGreenColor()
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white] //UIColor.SvatiColor.mainTextColor()]
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().barTintColor = UIColor.SvatiColor.darkGreenColor()
            UITabBar.appearance().tintColor =  .white
            UITabBar.appearance().isTranslucent = false
        } else {
            UINavigationBar.appearance().barTintColor = UIColor.SvatiColor.darkGreenColor()
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.SvatiColor.mainTextColor()]
            UINavigationBar.appearance().isTranslucent = false
            UITabBar.appearance().barTintColor = UIColor.SvatiColor.darkGreenColor()
            UITabBar.appearance().tintColor = .white
            UITabBar.appearance().isTranslucent = false
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

