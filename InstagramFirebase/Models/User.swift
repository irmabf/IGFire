//
//  User.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 07/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import Foundation

struct User {
  let username: String
  let profileImageUrl: String
  
  init(dictionary: [String: Any]) {
    username = dictionary["username"] as? String ?? ""
    profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
  }
}
