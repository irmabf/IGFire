//
//  SignUpController.swift
//  InstagramFirebase
//
//  Created by Irma Blanco on 03/07/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
  
  let logoContainerView: UIView = {
    let view = UIView()
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
    logoImageView.contentMode = .scaleAspectFill
    view.addSubview(logoImageView)
    logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
    logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
    return view
  }()
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    //restrict auto capitalisation
    tf.autocapitalizationType = UITextAutocapitalizationType.none
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = "Email"
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
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
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    return tf
  }()
  
  let loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Login", for: .normal)
    button.layer.cornerRadius = 5
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    return button
  }()
  

  let dontHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Don´t have an account?  ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    return button
  }()
  
  @objc func handleLogin(){
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    
    Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
      if let err = err {
        print("Failed to sign in with email:", err)
      }
      print("Successfully logged by in with user:", user?.uid ?? "")
      
      guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
      mainTabBarController.setupViewControllers()
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @objc func handleTextInputChange() {
    let isFormValid = emailTextField.text?.isEmpty != true && passwordTextField.text?.isEmpty != true
    if isFormValid {
      loginButton.isEnabled = true
      loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }else{
      loginButton.isEnabled = false
      loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(logoContainerView)
    
    logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
    
//    Remove navigation bar
    navigationController?.isNavigationBarHidden =  true
    
    view.backgroundColor = .white
    
    view.addSubview(dontHaveAccountButton)
    dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    
    setupInputFields()
  }
  
//  Custom Functions
  
  fileprivate func setupInputFields() {
    let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    
    view.addSubview(stackView)
    stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
  }
  @objc func handleShowSignUp() {
    let signUpController = SignUpController()
    navigationController?.pushViewController(signUpController, animated: true)
  }
//  change the black color of the status bar to white
  override var preferredStatusBarStyle: UIStatusBarStyle{
    return .lightContent
  }
  
}
