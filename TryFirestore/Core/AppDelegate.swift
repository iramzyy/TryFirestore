//
//  AppDelegate.swift
//  TryFirestore
//
//  Created by Ramzy on 26/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirestoreManager.shared.configure()
        return true
    }
}

