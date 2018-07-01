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
    
    let redVC = UIViewController()
    redVC.view.backgroundColor = .red
    
    let navController = UINavigationController(rootViewController: redVC)
    
    viewControllers = [navController]
  }
} 

