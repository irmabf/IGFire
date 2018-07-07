//
//  HomePostCell.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 07/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
  
  var post: Post? {
    didSet{
//      print(post?.imageUrl ?? "")
      guard let imageUrl = post?.imageUrl else { return }
      photoImageView.loadImage(urlString: imageUrl)
    }
  }
  
  let photoImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  let userProfileImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.backgroundColor = .blue
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  let userNameLabel: UILabel = {
    let label = UILabel()
    label.text = "UserName"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  let optionsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("•••", for: .normal)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  let likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
  }()
  
  let commentButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
  }()
  
  let sendMessageButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
  }()
  
  let bookmarkButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
  }()
  
  let captionLabel: UILabel = {
    let label = UILabel()
    //        label.text = "SOMETHING FOR NOW"
    
    let attributedText = NSMutableAttributedString(string: "Username", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
    
    attributedText.append(NSAttributedString(string: " Some caption text that will perhaps wrap onto the next line", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
    
    attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
    
    attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
    
    label.attributedText = attributedText
//    label.numberOfLines = 0 allows the text to wrap
    label.numberOfLines = 0
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
//    backgroundColor = .gray
    
    addSubview(userProfileImageView)
    addSubview(userNameLabel)
    addSubview(optionsButton)
    addSubview(photoImageView)
    
    userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
    userProfileImageView.layer.cornerRadius = 40 / 2
    
    userNameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: photoImageView.topAnchor, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    optionsButton.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
    
    photoImageView.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//    Constrain the photoImageView Height to Width to make a perfect square
    photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
    
    setupActionButtons()
    
    addSubview(captionLabel)
    captionLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
  
  }
  
  fileprivate func setupActionButtons()  {
    let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sendMessageButton])
    stackView.distribution = .fillEqually
    addSubview(stackView)
    stackView.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
    
    addSubview(bookmarkButton)
    bookmarkButton.anchor(top: photoImageView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 50)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}