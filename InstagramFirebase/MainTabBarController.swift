//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 01/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let layout = UICollectionViewFlowLayout()
    let userProfileController = UserProfileController(collectionViewLayout: layout)
    
    let navController = UINavigationController(rootViewController: userProfileController)
    
    viewControllers = [navController]
  }
} 

