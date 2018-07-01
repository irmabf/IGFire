
//
//  AppDelegate.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 29/06/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    
    window = UIWindow()
    window?.rootViewController = MainTabBarController()
    window?.makeKeyAndVisible()
    return true
  }

}








