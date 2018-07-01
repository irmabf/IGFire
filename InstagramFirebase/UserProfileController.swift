//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 01/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.backgroundColor = .white
    
    navigationItem.title = Auth.auth().currentUser?.uid
    
    fetchUser()
  }
  
  fileprivate func fetchUser() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      let username = dictionary["username"] as? String
      self.navigationItem.title = username
      
    }) { (err) in
      print("Failed to fetch user:", err)
    }
  }

}


















