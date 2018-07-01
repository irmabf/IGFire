//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 29/06/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
  
  let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
  }()
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    //restrict auto capitalisation
    tf.autocapitalizationType = UITextAutocapitalizationType.none
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = "Email"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let usernameTextField: UITextField = {
    let tf = UITextField()
    //restrict auto capitalisation
    tf.autocapitalizationType = UITextAutocapitalizationType.none
    tf.placeholder = "Username"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    return tf
  }()
  
  let passwordTextField: UITextField = {
    let tf = UITextField()
    //restrict auto capitalisation
    tf.autocapitalizationType = UITextAutocapitalizationType.none
    tf.isSecureTextEntry = true
    tf.placeholder = "Password"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let signUpButton: UIButton = {
    let button = UIButton(type: .system)

    button.setTitle("Sign Up", for: .normal)
    button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    button.layer.cornerRadius = 5
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    return button
  }()
  
  @objc func handleTextInputChange() {
    let isFormValid = emailTextField.text?.isEmpty != true && usernameTextField.text?.isEmpty != true && passwordTextField.text?.isEmpty != true
    if isFormValid {
      signUpButton.isEnabled = true
      signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }else{
      signUpButton.isEnabled = false
      signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
  }
  
  @objc func handleSignUp() {
    guard let email = emailTextField.text, !email.isEmpty else { return }
    guard let username = usernameTextField.text, !username.isEmpty else { return }
    guard let password = passwordTextField.text, !password.isEmpty else { return }
    
    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error: Error?) in
      
      if let err = error {
        print("Failed to create user:", err)
        return
      }
      
      print("Successfully created user:", user?.uid ?? "")
      
    })
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(plusPhotoButton)
    
    setupInputFields()
    
    plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
    
    plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
  }


  fileprivate func setupInputFields() {
    let greenView = UIView()
    greenView.backgroundColor = .green
    
    let redView = UIView()
    redView.backgroundColor = .red
    
    let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
    
  
    stackView.distribution = .fillEqually
    stackView.axis = .vertical
    stackView.spacing = 10
    view.addSubview(stackView)
    
    stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
  }
  
}











