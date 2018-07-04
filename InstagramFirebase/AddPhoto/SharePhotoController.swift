//
//  SharePhotoController.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 04/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController {
  
  var selectedImage: UIImage? {
    didSet {
      self.imageView.image = selectedImage
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare) )
    
    setupImagesAndTextViews()
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .red
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  let textView: UITextView = {
    let tv = UITextView()
    tv.font = UIFont.systemFont(ofSize: 14)
    return tv
  }()
  
//  Custom functions
  
  fileprivate func setupImagesAndTextViews() {
    let containerView = UIView()
    containerView.backgroundColor = .white
    
    view.addSubview(containerView)
    let guide = view.safeAreaLayoutGuide
    containerView.anchor(top: guide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 100)
    
    containerView.addSubview(imageView)
    imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil,
                     paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
    
    containerView.addSubview(textView)
    textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  @objc func handleShare() {
    print("Sharing photo")
  }
//  Hide status bar
  override var prefersStatusBarHidden: Bool{
    return true
  }
}
