//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 01/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
//    if the current user is not logged in
    if Auth.auth().currentUser == nil {
      /**
       *When the application launches none or the views are set up yet and with
       *DispatchQueue we can wait until they are
       */
      DispatchQueue.main.async {
        let loginController = LoginController()
        let navController = UINavigationController(rootViewController: loginController)
        self.present(navController, animated: true, completion: nil)
        return
      }
    }
    
    setupViewControllers()
  }
  
//  Custom Functions
  func setupViewControllers() {
    let layout = UICollectionViewFlowLayout()
    let userProfileController = UserProfileController(collectionViewLayout: layout)
    
    let navController = UINavigationController(rootViewController: userProfileController)
    
    navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
    navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
    
    tabBar.tintColor = .black
    
    viewControllers = [navController, UIViewController()]
  }
}

